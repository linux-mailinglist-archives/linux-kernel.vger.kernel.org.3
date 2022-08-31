Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180A65A8418
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiHaRRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHaRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:17:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F4C9EAD;
        Wed, 31 Aug 2022 10:17:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 145so14711118pfw.4;
        Wed, 31 Aug 2022 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T4UGwzDODqTvd0H9FJ6M3OtZ//owxPRBI8qqCrzGGw4=;
        b=lkYmnYzn8tj7ARWmbT1SiXpprCCJx2Aq92C3qPT7nk+MH63Rs83g1B1ANYyPsKU8LU
         qOxKhXDyWIZcndI/z0vTEEzPSf4GIqinf7YuofChg/VstyKRoH++aAKThc7xqb9Pkvdz
         e0pTqLRiaHLRTQSeAqLp9Pwfi5vJQwqtWzz8p19aXLgdMtnVOr1CRjZodq4/Sm0rQA/5
         oU1kSSAtvbN/+mU4y0WtaXoVLV4Fb5M0jmgbVKcplcj/s4Dn8e8sSmgCPmk9/RRlj4B0
         aoFH3P1uYRCp4gLPkWEeRCAkSqLkIU8UaBYxF17NOsM1YpJKx93Um6U8isGC1Z1RR/2d
         ULsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T4UGwzDODqTvd0H9FJ6M3OtZ//owxPRBI8qqCrzGGw4=;
        b=m6wV1ASne/VR/duugE3cI1bzqx9BkFCkt0i5lxSDK5pCgdF5AfB6AMgeOFAzdFEBwN
         BETswm4aqVYH4+lRReMZ49w7rOSe47qhFnPwAOnGBb87cPEnZFz7EJvJwXUCuzbjF8GK
         GRRevfSZGixmiLsFdBcOari/QNx8wp6s3XSRFsZvFsLVNwCOH3kID/U1fzewoGqlYvr5
         6gezpvf3Qz4id6KKpIr+lcOmw4SieOkfYq2KbgTUmbZSgSaz4zbvnJUgNmx/M58ohmMx
         zeaHsbeZIvDZHkOSH9DBh+7OJVlZWwpa5fRA/KRejqAN59zMfeakd1kddsr8T088qZoE
         KYeg==
X-Gm-Message-State: ACgBeo1TKwIDBEewb2MIfIxr/HZNw3QQLhzHlpsloebDggpY5PMTBcXm
        rsn1KGJ4Mn5LCl8eVn5xK4U=
X-Google-Smtp-Source: AA6agR5lfXWZtQuSwozCOFnt1Vs/Xna/9ZCUETNDVzY4P0jFS+RWpFfAyOtE39baGtg58vfCVxr1Dg==
X-Received: by 2002:a65:68cd:0:b0:42b:4214:27 with SMTP id k13-20020a6568cd000000b0042b42140027mr22839534pgt.102.1661966235289;
        Wed, 31 Aug 2022 10:17:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b00172ad9674e5sm10500593plk.291.2022.08.31.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:17:14 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:17:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: input: colibri-vf50-ts: Improve
 documentation
Message-ID: <Yw+XmCAgnbmp5AQ3@google.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
 <20220712101619.326120-3-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712101619.326120-3-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:16:19PM +0200, Francesco Dolcini wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Clarify properties definition, drop unused pinctrl-2 state 'gpio'.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thank you.

-- 
Dmitry
