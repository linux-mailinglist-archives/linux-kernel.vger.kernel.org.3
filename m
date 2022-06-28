Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D355CDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiF1Cuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiF1CuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:50:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A51BA464;
        Mon, 27 Jun 2022 19:50:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso14425469pjn.2;
        Mon, 27 Jun 2022 19:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ETFvCJDkMWVKNQmoI5Nns3Jh53dLVPbmFnZvoeDNTng=;
        b=ECfvYc14OvCFGIREHJjFh8Hrxg9nUVFwcO4S+Y4ZdkRU8wViZ82YvkY212ZQFYs2E9
         H6HiyqDEkV7XdT5Rqo6G3zG/gXo4ELz5d+UaC/gsWFjpP5iRU1yeTBuuWIqvoIUEshSs
         ks/xCoQg9EN41KC793055nzxHDdmBBHr+t+AfT8OHhLQc9acPI8wHCuvuwHzg86BNUTS
         Lp+KnjiQyI/7LQ4Kr+jAczOKwcUxF7u9v0vgvvOym9nN9FxA2Kg9/mvGybAdt374RNR1
         /nF3jjARQFR34lAHsiVT34/uUMyqwV+e43BaLKyNNtC+W0mQAKJWTC2xJpcXBG9uouiu
         kvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ETFvCJDkMWVKNQmoI5Nns3Jh53dLVPbmFnZvoeDNTng=;
        b=uYX/Xt6gpNoppkk3V3kv4lrwSm1cFIMtxfHJm8Di5wzJXqkPxtVGCxVSLnBbS/wb5i
         Lz5tf+j7kBeY86EaGF4XWy1H6Ih0d00W4dFGrMH8ay4ufHxxPD02y7gl0uLPzzf1fOz2
         Yrx21o/JDgIOe17oPatSWG5YINmPq7Y6TC3XJguo+QzaeXKfJckoe3gin1U+jPNbORZ5
         SwcH607ysCrDV2DP9YO5XhqfNbTSiR5YUCmlgJVe+Uf4umYZgFh8pvUOv04JYs03R0mb
         1B3Aa9VFhD8iNOtD5ItCCBAb6kvvekmdFDZPxd0jiutQ+6aoEWqfcpA8zJQlwuokzK+/
         xudw==
X-Gm-Message-State: AJIora+XwJnelGS3F6va1R6nQSKZukR5m7m5PbeiRTL4XluuVdhXx0cY
        107zAT+vsmgioXi4DtgsFuk=
X-Google-Smtp-Source: AGRyM1tYbPxFkoh5FPA6F0qIk7eclhnJVIzQjH1Kl05DF9q6+QP9UVZWne0itU6qSZml7wLtF4Z7GA==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr2661774plh.92.1656384621661;
        Mon, 27 Jun 2022 19:50:21 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id d63-20020a621d42000000b0052532d9cb18sm7982150pfd.183.2022.06.27.19.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:50:21 -0700 (PDT)
Message-ID: <c7c21381-fa1c-a67a-e5e0-ac590fe0612f@gmail.com>
Date:   Tue, 28 Jun 2022 09:50:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 00/11] docs: remove submitting-drivers.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 22:18, Lukas Bulwahn wrote:
> As future work---with this one submitting checklist gone---I see the harder
> follow-up task to synchronize and clean up the various submission hints/
> guidelines/checklists in the remaining kernel documentation that partly
> overlap and differ in detail, their structure (unstructured, unordered
> lists vs. sections and subsections) and their state of being outdated:
> 
>   Documentation/process/submit-checklist.rst
>   Documentation/process/submitting-patches.rst
>   MAINTAINERS#Tips for patch submitters
> 
> My next task at hand is to read through all three documents, figure out
> what still applies and what is outdated, determine a good common structure
> for all three documents, include cross-links and make them to some extent
> follow a clear consistent policy. E.g., one document is a more detailed
> description of everything mentioned in the short list of another document.
> I will try to work through that in the next months or motivate and guide
> some colleague or mentee to work together with me on that.
> 

Hi,

I think MAINTAINERS#Tips for patch submitters contains redundant info
compared to other submission guidelines, and some tips there are outdated
(like using `diff -u` instead of git). For consistency, that section can
be removed (in your next RFC series).

-- 
An old man doll... just what I always wanted! - Clara
