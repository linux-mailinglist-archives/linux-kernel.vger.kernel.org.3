Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5758A02A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiHDSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:05:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032C6251;
        Thu,  4 Aug 2022 11:05:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j4so159779qkl.10;
        Thu, 04 Aug 2022 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aB/PldDZXUYY/be10rIxd+dJr9axoQmchPJ7d8SPF30=;
        b=Ar5jsIsj5W+aSbtcehzlbML3DXX7e/p/VGk4Tz6qTWegTbSN7/xXH32K9OUTCTMPWn
         d3ADVBgz6JyKNMhUqUtOsVurYgXsufKEfnnTb0mNAC61luvJ/t9VEhXjutS5O0am03sA
         9rMH0KtH3+TuR2QfT+2jg/kJCzX0FlSFaa/7P5N8h9ie6CyuwaQ54WbfJ5aWAMhy9Qj5
         24WBZskQtqAutIjbbz6X7iFnZlmuYXsmPdabUROjaLBhuSssc0N1/bHlQokk8qdXJ5rR
         1DlN8eDlwBjbvb3KbH1Nc1N8PMK9hZaIJg9PzcdUmZ6Kmbnj4XazaG3PZU106dXZLEeb
         KLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aB/PldDZXUYY/be10rIxd+dJr9axoQmchPJ7d8SPF30=;
        b=q+nmLJJ3eSfqi8f0IeVTAVTB82qYAUWP51Bs7nbRHIGOvOIfP/i+pXjDSqWd/8/OKl
         aw8qYLfg9/VXp10KX4bZvbtgj2NiqPxev5HoI0KcTc8M7ReoiM2LfgqcVs+aoTK4iHCW
         pXcaNe8k5XTi6gP5WzDZfGZ8DcSClmvATER6psZIMHAnVS/D3j88rIoNouDTXI56eA5n
         ZdQ/JWYoN6iHukwtGCCkQG+ckQMD4zlThWC4W0sNTXFE8/X93Mat4gXEyeCDgq7J0cn1
         cLVV/a4OgTL5AqQ0WNDLAsxkx9fUnjKzI1I/Ng5G1zAcR9AuOLzrh2r4VTGxZEgnbGF2
         KreA==
X-Gm-Message-State: ACgBeo0RLgoPxToFzp1uOiLkbGkzs1qvDXCN3B02BOrjyHFLWvLqiyc9
        BGPX+F5pqBDXqSyhH7EPLho=
X-Google-Smtp-Source: AA6agR7fICJICh6oOG0o42l+SmZKcPlsqrj26H4vT8led2b3p4gz3z0wOCx+hicfTVVjw8Hz8IX1Hw==
X-Received: by 2002:a05:620a:28c1:b0:6b5:e608:3edd with SMTP id l1-20020a05620a28c100b006b5e6083eddmr2470378qkp.730.1659636320667;
        Thu, 04 Aug 2022 11:05:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i9-20020ac87649000000b0033d7ea63684sm1033895qtr.54.2022.08.04.11.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:05:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: bcmbca: bcm63178: fix timer node cpu mask flag
Date:   Thu,  4 Aug 2022 11:05:16 -0700
Message-Id: <20220804180516.1338796-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194448.29363-1-william.zhang@broadcom.com>
References: <20220801194448.29363-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:44:45 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> The cpu mask flag value should match the number of cpu cores in the
> chip. Correct the value to three cpus for BCM63178 triple core SoC.
> 
> Fixes: fc85b7e64acb ("ARM: dts: add dts files for bcmbca soc 63178")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
