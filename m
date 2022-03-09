Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80404D38B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiCISZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiCISZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:25:08 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945BB1A;
        Wed,  9 Mar 2022 10:24:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t2so341186pfj.10;
        Wed, 09 Mar 2022 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSc2PmZWhcE4zmSNYcCPse2rUDVrpRpLjcHq7MCZReg=;
        b=IrgulhdKzLO2MikUiCP6c1vFRk3ZGBL4uLphiYRGDnhtmP6KX0EsdhcVXAWmXCV06j
         tXazOnOFyn2zk5TMa9dRp1sp4aNLVs3K/4PzWJm/Nvn5bDTT1iT8KevY4PwGOG3gqL2E
         gUNQaIHGNP2XhLcWzkQ2n6vnb201tg0daclONcn+FkS7K6QADiinn+uVVxOvtlo37cpv
         dW1w7v7uqfEEwty2OehACNanTMWHCBQzMPBbUxsjxzWdvUrbbL7uEqrkVA1Vln07GfDE
         8FFdJEjkoDrSbnfDBC1oC5ppWd23zDHIXhb15fCWPMul4sDcunOQU9S0OSTZnKxept62
         EbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSc2PmZWhcE4zmSNYcCPse2rUDVrpRpLjcHq7MCZReg=;
        b=f6SD40mtILB2kP4KXfag6ichQUBZrLZqlxtomNmjb+aQsZFcpKO0VzZC2/6qC91/CX
         k81r9c85AY/XOYXXsAUM8EYkqfTyTOslEp3NmZXw70OCpZVUqZ2Iza0UX7xsKdQgO7VZ
         8qo9lAT8k5AOoaaUxYMjq4rE3+aJV1SU+jSss/E5fg2Xp0eSDV+kIpaPRoaQJlqDlUEz
         g893nK2oN7TLIjWdHyfsMpUQRI36fdAKgt6j1sZTGW8TVyjeznvy52bud1iKLtqc1jCT
         SmPwhJkqR+dn7zLVVTC+jPDJ+dJZLQ/1Aa0DZwlssz3tc0pVM5IPoErAswoKmrxmNq5m
         cCaw==
X-Gm-Message-State: AOAM532ilUU0vVRaCG207N5TM+N/+7oPq5+B2wL5lxfD3LqDEp2cqz7m
        fJT/xndvKhqjZtpiNNvtLMg=
X-Google-Smtp-Source: ABdhPJwI4GEboqNNCjaUvxKYP+YouJqvdWOikH3LnYpmPQ5D3T9sJFcSAgxgPqrEZ8PHpve68F+CZg==
X-Received: by 2002:a63:e42:0:b0:374:7dae:aa98 with SMTP id 2-20020a630e42000000b003747daeaa98mr841107pgo.586.1646850248480;
        Wed, 09 Mar 2022 10:24:08 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004f754dd3d4csm3950988pfc.3.2022.03.09.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:24:08 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Chanho Min <chanho.min@lge.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 0/2] Make DTs compliant with bindings
Date:   Wed,  9 Mar 2022 23:54:01 +0530
Message-Id: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are an attempt to fix DTs which are not in compliant with
pl022 binding.
LG1312, LG1313 and amd seattle platforms require fix in clock
properties.
https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/T/#u

Based on git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git,
master.
Rob, could you please help in picking these patches as git tree is not
specified in MAINTAINERS.

Kuldeep Singh (2):
  arm64: dts: lg131x: Update spi clock properties
  arm64: dts: seattle: Update spi node properties

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1312.dtsi           | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi           | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1

