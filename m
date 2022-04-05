Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AE4F2C16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiDEIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiDEH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:58:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8AA1473;
        Tue,  5 Apr 2022 00:52:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kw18so4846585pjb.5;
        Tue, 05 Apr 2022 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TgBLJeTUy6jVJ2xafVPcKSUbrGijHeGdKDekFNJpES0=;
        b=aSMeYscyjfPJ2j6WMIt8esKgLv+cCuEG4DZPmO25jSIgyFHFNthTEgjQWkML+GAsZo
         sfyoc9olWYN1DoYbUFMZJz/3xOg9AI+pSaG6rQGNVombA5eN5censAMjYkrUnh0N7cp0
         VasbFqTcDXjOKc4QvMO3qHl8UxazmUpkfUXfedYDhKa3qmj2oviN65D+MClQTzAc8kW5
         4U7v6v+wpnTFd/6mazsybeib5GY/iM8b1zIvJ63foPySXQKx7b6zaUEFg5Am08pNPbB1
         zrqvFH1xVq/0iC0tIEaTAq05uIyEJlRGxNCVYCatVgBpvP6VF2IzpeBmxQ8OLcpjjxWD
         dREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TgBLJeTUy6jVJ2xafVPcKSUbrGijHeGdKDekFNJpES0=;
        b=7G606hXRhc0SU/ms8DpFDf6iz06FnZodNfV/u9PlyQI+x1VNoNSZ3sxgvREuTn2QMW
         /5uiG4qh5HSipvaGEuH+x+f24+VVFTsB+3Ra+RbwmWCtWUrr+nqdwprZWbaISaTnlQdO
         suP5/Aalgkr7Jl10QyHVBTCJ4pUMbILP6aI+g+Pc7L0FpzGFdoM9lp9WpJeqeKK4QPKy
         iw3Y4Y6eXAJhYnsqE0UcocYcnV1lgT9qS7M74NA36AIZ4H0dCnbSPkFeMlKO/ug65K9I
         vrwDvzk/BoN1fYWNf+SXmglrWiQk9yc2+cXhxigqaFW5Jrwp4R0obGULxGy/dTRlpQZC
         cFqQ==
X-Gm-Message-State: AOAM530d7mxSrjNR9Pc/fWPP5a/oE/Lweduz/DUHubQtBDtsKj3Ebksi
        1FedWG0RFmWRdwE9rnEqkis=
X-Google-Smtp-Source: ABdhPJxwe5VM3sjwzmEQs7uSfq/7UjTSJjpOPqAE2YvqWv6No8h0U9MnptFRrXgdvlyfWFHIJLhlTg==
X-Received: by 2002:a17:902:bf07:b0:150:9b8a:a14f with SMTP id bi7-20020a170902bf0700b001509b8aa14fmr2206809plb.127.1649145148521;
        Tue, 05 Apr 2022 00:52:28 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm12821367pgf.71.2022.04.05.00.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 00:52:27 -0700 (PDT)
Message-ID: <1b01580f-f888-5725-e571-816073148303@gmail.com>
Date:   Tue, 5 Apr 2022 14:52:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: unexpected indentation warning in
 Documentation/ABI/testing/sysfs-*
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
References: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
 <4df1fc93-2a2a-3482-085f-3a88970440ff@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <4df1fc93-2a2a-3482-085f-3a88970440ff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/22 19.54, Hans de Goede wrote:
> 
> These 2 are fixed by this (pending) patch:
> https://lore.kernel.org/linux-kernel/20220324165918.22005-4-hdegoede@redhat.com/
> 
> And I also have this pending patch for a pre-existing warning:
> https://lore.kernel.org/linux-kernel/20220324165918.22005-3-hdegoede@redhat.com/
> 
> I'm not sure who should pick these 2 up ?
> 

I think linux-doc can pick them, if no subsystems do it.

-- 
An old man doll... just what I always wanted! - Clara
