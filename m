Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3EB5AFADC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIGDvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIGDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:50:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC5E6478;
        Tue,  6 Sep 2022 20:50:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so12407473pgs.3;
        Tue, 06 Sep 2022 20:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SpiI/4f8FqhFil8KI2sz06Ugm43wYlDdfEt9V7Lez9o=;
        b=hRceYyXBMlxR6vqMH0zkfXuONAT8QQStUJjFgoiHfBtSgE/8YgvDDounisz6H+qX8B
         /E/RnprcwXdlqXLK2u7ZE0o0uj1CPNLL91lU+xSdlLDs5i7mtqggdRuqUvY3W3MJwhHR
         e7s+PGjn7jiI0JpcC0GBCKT/nACyvxJdpCOuEPTlpTSudJv7l42angNYzpxbIsybWcPz
         0xqH0KPZC8K7IWLl2N9yN4NGny068UL8diKoK2n9vyDsqq7NnV1smjq0ANHcGvhJZ8jN
         VTQegIVUW0saidv+gX5B75kdOLi7KL1uXvxqC8qJUyiqj915z7Ui1yqT9cMCdMJ6ypN1
         SaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SpiI/4f8FqhFil8KI2sz06Ugm43wYlDdfEt9V7Lez9o=;
        b=DDubzbT6/MgfvO/NqwF4FQCCjJAagzSE10AML8FB9mPMKB8DorgtMgEexsCPtoZo3f
         l/W57IL3fngXmwzIlwywG1O4b7lpVc03Zp4tm8QiiCydzrW2JRKXT3Ocu2v2XEWEWJDd
         X5nHIdAY/WhIQHN8euXL9Oggu18W/L6s8v6o3u7yci9AzzGsS3SyNk2kCXogYCjJ7RSX
         TJQCp1YsjxRkIlbus6dIkTS2DYu6bSxjJo5PXpOBgUZET0mJZdlyF1uevM0UxcLnfGqC
         CuNaEKtYaduTVDyI07TmBg50GNxet7Ns7m8+43H8VBd+c+vCAuCP9BJbD7XXk3jmh4Zw
         BWzw==
X-Gm-Message-State: ACgBeo0od59KayMKn5Bs1dmx5RVu2eE62Yyb7WpNziMuK7dJqBuh0lmR
        EsnSGnVo996t98Wum39cK8s=
X-Google-Smtp-Source: AA6agR7mO4OR+6jVK8HVMy79jOj63dNiEmGJLTgGQXCyVoy+JtvdqrtqJfjIhTYG4diadwe6dCBBQQ==
X-Received: by 2002:a05:6a00:1aca:b0:52f:55f8:c3ec with SMTP id f10-20020a056a001aca00b0052f55f8c3ecmr1649565pfv.25.1662522642094;
        Tue, 06 Sep 2022 20:50:42 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id 17-20020a631751000000b00434e00227a7sm606189pgx.4.2022.09.06.20.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 20:50:41 -0700 (PDT)
Message-ID: <ae1e3abd-cafb-7059-b8ae-5bcb13d53b40@gmail.com>
Date:   Wed, 7 Sep 2022 10:50:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation/process/magic-number.rst: kill
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <20220906003828.aqrcmjzuri5do4uq@tarta.nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220906003828.aqrcmjzuri5do4uq@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 07:38, наб wrote:
> The entire file blames back to the start of git
> (minus whitespace from the RST translation and a typo fix)
> 
> There are changelog comments for March 1994 through to Linux 2.5.74,
> struct tty_ldisc is two pointers nowadays, so naturally no magic,
> GDA_MAGIC is defined but unused, and it's been this way
> since start-of-git,
> M3_CARD_MAGIC isn't defined, because
> commit d56b9b9c464a10ab1ee51a4c6190a2b57b8ef7a6 ("[PATCH] The scheduled
> removal of some OSS drivers") removed the entire driver in 2006,
> CS_CARD_MAGIC likewise since
> commit b5d425c97f7d4e92151167b01ca038e7853c6b37 ("more scheduled OSS
> driver removal") in 2007,
> KMALLOC_MAGIC and VMALLOC_MAGIC got killed in
> commit e38e0cfa48ac38f4fe24453d2523852467c95b21 ("[ALSA] Remove kmalloc
> wrappers"), six months after start of git,
> SLAB_C_MAGIC has never appeared in git (killed in 2.4.0-test3pre6).
>

Seems like incomprehensible to me. Did you mean comparing pre-git era
changelog to current doc?

Also, the subject line should be "Documentation: remove magic number doc".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
