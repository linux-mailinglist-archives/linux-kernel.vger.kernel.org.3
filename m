Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE514E50B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiCWKxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiCWKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:53:34 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBEC76E2E;
        Wed, 23 Mar 2022 03:52:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id w25so1322754edi.11;
        Wed, 23 Mar 2022 03:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rN9pveEJ29B8GyStVJYVmzF67QmvDcdu3gRq0V/RTnw=;
        b=P7FuyBTO7HWXeDjAS6mNfJiSEhmSbBUcQZHVVBwi8pVEllamU/GAQPnZvinH35hTmJ
         hNVoe6uShj80WhwHLpx0Y6EO+0tpx/rTLfvPkWB0GRqUjtV7QSWbMS+dNbGazTcVScjE
         8Zr8jYtfekfQcxzSJ0/pb4cjG5mRhhyJJoYTmsMw88lkJBWhsWSEDE5kF5IIuI050OcL
         xYKXwpDyS3WIJalJtUkK94BBZQ/KDQ1t6NpvHR8Drca8mtiFsXHEn24dKl7YbQCfoLLh
         Y56ySD6/Gn5VpBmNZtGL88cY6scASHSdOECyxRUht2UeG40M3H9WZPvOvpBmz6/o/eqi
         +kKw==
X-Gm-Message-State: AOAM533D3g841UuDzMiNBtEUzv/BqsiorL8PmiL5/xbG597dpbY8NvzS
        VSeFhdIHQBeVlZja2/jeMAE=
X-Google-Smtp-Source: ABdhPJzB6AoxcGP4trJZVuO/kcv6Lsp1C4jKdPniKJuuwATRMLZRDeX9D8QFuOjnBqPc+JoTnCWwQg==
X-Received: by 2002:aa7:c415:0:b0:418:f844:23d9 with SMTP id j21-20020aa7c415000000b00418f84423d9mr33443387edq.337.1648032722761;
        Wed, 23 Mar 2022 03:52:02 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id y27-20020a170906519b00b006dfaf4466ebsm7271424ejk.116.2022.03.23.03.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 03:52:02 -0700 (PDT)
Message-ID: <2608d7bc-2c23-8c66-efcc-77d2e23dee61@kernel.org>
Date:   Wed, 23 Mar 2022 11:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 0/7] ARM: dts: s5pv210: Bugfixes, features, and
 improvements
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB05673676DA7E6E4BF275305ECB179@CY4PR04MB0567.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB05673676DA7E6E4BF275305ECB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 21:21, Jonathan Bakker wrote:
> Sorry, it appears that I ran into connectivity issues part way through sending
> the patchset.  Should I resend the entire series or is there a way to get
> git send-email to retry/continue?

With git send-email you can always send remaining patches with
--no-thread and --in-reply-to=XXX, providing valid message ID.


Best regards,
Krzysztof
