Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0563574937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiGNJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbiGNJij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:38:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7809C49;
        Thu, 14 Jul 2022 02:38:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z23so2372355eju.8;
        Thu, 14 Jul 2022 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0YVc+Bx3WqyVLXKIj3bH2GTxd5KH0UstclTJN/1u/WE=;
        b=dwzg4sBJWxSdicWdUFD73FW7z+6dzTpBY6nx5Juv37VpTV7o9QmLAgbMb5fSGeVOwa
         FxceD9ssmBP3SxogEMRzAH7kzEfFefiD99nhDMuqHsW5ck0x/S+pmMd5GN6Jt9+CHaZW
         a1pSWRi1VWNG8GvT/ib0MFrSKVxURCyoKSYb6jyXaNsHFj0Ej99K0F9hwotsH3Ep6Kdw
         C2XmVCtP/Wn5xDR1d0ZY7W8rQ6wVsLGjlgDU2fNPanBPBJ4/m9C5HkDeDA5+ZWAMk2vJ
         KSJpKFrt7kzpaI81BzhP3BfOeq1rHJbFJO/NjcryE6+I7K884O41iuxJm1CQuq8EHc3j
         u2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0YVc+Bx3WqyVLXKIj3bH2GTxd5KH0UstclTJN/1u/WE=;
        b=49kA6Car4mP0jImL8fekIrX8FBq7BzSvCxUbXaHtwwZ3FoROvSOveCT7O6/aQYUdwO
         AfeSOz7RGla36cDdRVdUabBE/9ghmpYSekxK01NqdhCqyUU8fJDtqd7jRPBCrqIQUh9q
         uvkm2Cm5zw+iI6Cs1cOPSsCgnzkoW/DJ+MkAwburvJnYiNRVz/BGBMOqyDbTurgtVG/m
         nddrIQV1NWFypz4MUZbrrqLlKHQ9/ZHp5ypv07jFPsYNtPXUz20p9Pwt8NfIssXb81aT
         07agLGt6BglV9NEJHN1S8APcSLKW4bITjP+RRgdN0n6OW8KEnfmOUnqwTdH3PvTXv9Q2
         en/Q==
X-Gm-Message-State: AJIora+wyn3JwoMtt5UPFbiKXiufx/NgrsWiMGnp9mVR0RcQHxPe5kcj
        NjlCIpmE6XxSu9iHuJJxZq/K1oxPMUlWo8wR
X-Google-Smtp-Source: AGRyM1t5dTFWFfuwUVmy1eX+5yXmGA0KsvjJ5YE5mheW9KkskYsjqTMkQtpy0QpVTZOkezjrOB+/fQ==
X-Received: by 2002:a17:906:98c8:b0:72b:3a31:6cc3 with SMTP id zd8-20020a17090698c800b0072b3a316cc3mr7735627ejb.597.1657791512519;
        Thu, 14 Jul 2022 02:38:32 -0700 (PDT)
Received: from [192.168.178.23] (h081217087223.dyn.cm.kabsi.at. [81.217.87.223])
        by smtp.gmail.com with ESMTPSA id ek9-20020a056402370900b0042de3d661d2sm727202edb.1.2022.07.14.02.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:38:32 -0700 (PDT)
Message-ID: <0f7f7bf9-c4ca-57a7-0320-0f149965c83d@gmail.com>
Date:   Thu, 14 Jul 2022 11:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation: process: Update email client instructions
 for Thunderbird
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713225037.1201-1-sndanailov@gmail.com>
 <f943bce5-32c7-9339-14ce-876036db7c46@gmail.com>
From:   Sotir Danailov <sndanailov@gmail.com>
In-Reply-To: <f943bce5-32c7-9339-14ce-876036db7c46@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jul 2022 03:08, Bagas Sanjaya wrote:
> There's a remastered version (uses MailExtensions interfaces) of extension
> at [1], suitable for current Thunderbird version:
> 
> [1]: https://addons.thunderbird.net/en-US/thunderbird/addon/external-editor-revived/

I should've added a specific addon as an example, thank you for looking into it!
Also forgot to mention the "Account Settings" for composing in HTML.
I will write a new version of the patch to clarify both of those issues.
