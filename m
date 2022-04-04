Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820C4F1CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379371AbiDDV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379991AbiDDSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:35:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498B2E0AA;
        Mon,  4 Apr 2022 11:33:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so171417pjb.0;
        Mon, 04 Apr 2022 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX36O/eZvePOVXNXSBF6wdkEoqZXyVTUQTus33r+ZLM=;
        b=Jhi/m3HKdiGTMNmkPf5/IrS8tqIn7BB3PQz4dCz8wsIKHrcI9VonrT+jshZjvR1D2Y
         gZQIvWaiPpb0+mDRElRwfXipdX2RNh+Jb/3ctTU4NdbRWYZI7cGDUSfaA/USDvArb4ig
         +xUxqpbegNbNMvXnHaXweqbb6lqWE4t2JOK8VNGBALOD30nLnDdfsggKqKKzKRScLH1q
         U61hO7U2Z13BDegN5qKzi2eNImhkSOJEg0ghkPe0Eq0KB37+cFM8xT+R42EuZV9Hl56d
         mCoQO+x0AmxMO58teRYmy8LIg9qOM4MbboSebePuOJuSi+M1iGUqeETmyBFMNAOfQm7I
         gORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX36O/eZvePOVXNXSBF6wdkEoqZXyVTUQTus33r+ZLM=;
        b=kEK2JAPNokFrDWMG+cAjTIUNajiwcz68/kow+O9bygDkYg5O50y4DkhddADyic0rL/
         /FqdNnMN0JavuaE6/7TOT826vMwYR2KfQyOAiiC5oYhrj37hrD13LGNdKqYd9q/l9PaV
         iW6ap3rKhHrM+F5Tb/9ORTI5lWkLUpp5tHKau6YKCY9loV3rTe03rIDu3Z/Flwm1WwC3
         0PGWDzHFipPucHOU1TI9TYbs0bOwU2pKMF+WmpkGhQJgQa2qwgpcSrHYs6xrLp591xK/
         UW1GU8298uiIF2Qb4uZhqVCDDmthto6V9m7siBimusgingV4dnnSsGvDAzo/BTHPgC+7
         0/Sg==
X-Gm-Message-State: AOAM5312S0fheYwp7O7Uh9VtIR2FIf3WZ8yBy8nBzBqNYCijXBZ1uUkA
        AJ+kxW5KVr9PYLqM/S0sqgU=
X-Google-Smtp-Source: ABdhPJyjzPk/Y9vMf+i8TBGcz920f/PKNrlqh4kdhA3wSJBIHQ0Ba38XDLX3ubdJQZyY3wZP6/PISg==
X-Received: by 2002:a17:90b:3b8c:b0:1c6:eb72:24b4 with SMTP id pc12-20020a17090b3b8c00b001c6eb7224b4mr510870pjb.171.1649097196928;
        Mon, 04 Apr 2022 11:33:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b7-20020a056a00114700b004f7be3231d6sm13069546pfm.7.2022.04.04.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:33:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm-cygnus: Update spi clock properties
Date:   Mon,  4 Apr 2022 11:33:14 -0700
Message-Id: <20220404183314.2316058-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311084114.16408-1-singh.kuldeep87k@gmail.com>
References: <20220311084114.16408-1-singh.kuldeep87k@gmail.com>
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

On Fri, 11 Mar 2022 14:11:14 +0530, Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> PL022 binding require two clocks to be defined but broadcom cygnus
> platform doesn't comply with bindings and define only one clock.
> 
> Update spi clocks and clocks-names property by adding appropriate clock
> reference to make it compliant with bindings.
> 
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
