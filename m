Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE658D562
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiHIIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiHIIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:30:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35212AFF;
        Tue,  9 Aug 2022 01:30:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so8361994pgm.5;
        Tue, 09 Aug 2022 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Q4L5FOTMe4AJdJJMn6Pl0PtIME6CYddRd63dmOS6kRQ=;
        b=YehJQcfbdLP1a3hj8YEzB5kB0Fo89XPMrfdI9hqQIQ3C5RiKO3DTShPd8MnAB0m7nW
         pYz4R3GtB8B862AnFkYOZLWALW6YVklqRx0T4gW3f+QnBBDfC2YfklPzXhtOFyPGMMRP
         kKQHtHiKWwHrAyW9cW5kQdjf2KYVknfJ4e5CvRTaaFb+CJJCjeW11CsWmWljbL0BVpQy
         2Qq5oEDh/720VY31hW6YBk8+o3kWA+QzWPqwcdeSOdmlgtMGIp4f1Uil3l7ud4eaCBqk
         FmLbzkzQfRSXsc8Y7vqpV1B5/de0Tqaw2YfkE+dB8nIdvcrtiezpFlgIUofAfglKNnyE
         qfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Q4L5FOTMe4AJdJJMn6Pl0PtIME6CYddRd63dmOS6kRQ=;
        b=0ztFBiB5XNOCK5hh8omQ+0a2Uvoa/d4LntvcmkZpZI5Z61UGZLDHMHYRp/bRjb/cyV
         s1MabU+pTh4XNHhe0HOZiuAXHIX0yABM/K+DOByGq81D3RSV+MVfTUPmcLA1ZIFbHpOq
         dcnQSMPZHRcTb7vJDthaXPUahTwEzOBg5Ooh57K86/+QtsHPq2tSxlWVASjAv3967oJ7
         60OcEhSEZSLPcEd0gGtsnjVQmIHllwViNbjAIBrQY3P8gVcsgZRj8/b/fgDdlBg88i8j
         B/PmfFm/Hh+90oaWqBkYBujlPHDMCUwlGKpMkl2f2RVOKv47dAW1eLZN9W1mUuwN5L64
         WcKw==
X-Gm-Message-State: ACgBeo28m911zSORhnpGmS4xOs+pibjFpdTwV6WvrKq0TDv49KYT6P+n
        TAe/EgdK8X+2w5kYtiAWrCg=
X-Google-Smtp-Source: AA6agR40vlVtmWsCZ0vzwxc1xMptLC9rc82nSSYCshTc1G5a+IoniYvNLPNDWSRN15NcWfx3G8BhCQ==
X-Received: by 2002:a05:6a00:1490:b0:52d:9ccb:bf96 with SMTP id v16-20020a056a00149000b0052d9ccbbf96mr21807639pfu.31.1660033851954;
        Tue, 09 Aug 2022 01:30:51 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-42.three.co.id. [116.206.12.42])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b0016bcc35000asm10155043plg.302.2022.08.09.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:30:51 -0700 (PDT)
Message-ID: <9046f8b3-2bd7-64c6-5da8-d1c4b935b1e9@gmail.com>
Date:   Tue, 9 Aug 2022 15:30:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Documentation: stable: Document alternative for referring
 upstream commit hash
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220809045543.2049293-1-carnil@debian.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220809045543.2049293-1-carnil@debian.org>
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

On 8/9/22 11:55, Salvatore Bonaccorso wrote:
> @@ -97,6 +97,12 @@ text, like this:
>  
>      commit <sha1> upstream.
>  
> +or alternatively:
> +
> +.. code-block:: none
> +
> +    [ Upstream commit <sha1> ]
> +

Looks OK. Indeed Sasha uses the alternative style.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
