Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31B587375
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiHAVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiHAVnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:43:03 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2EA23170;
        Mon,  1 Aug 2022 14:43:01 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id f11so10771715pgj.7;
        Mon, 01 Aug 2022 14:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/Uj3k4mtLY63OgD/JEu30S8Bzg5zX65s31dnHrHQ/nI=;
        b=J6xI+S4dxCFfHt4TUbZAFWUFsZ2hs+uzLlsrPE8VhXSkP3V/Ng4B7bzgtq8m+rmkCi
         03j7FZ79KfvcHO4lt2krWIXuCNIxI9jC3vPQuGopG76d9Umi8kNEfBl5csImDJ1ker6y
         YlbDblFbGQOBQyJBC1EWNv4cMEieghlJaNR2UKfv3Krg/5ly9UnhEAt1vwgEhZhDw7pm
         ioutNi3Kr64JfwCA2bYb8V8boFSbvHLflqyXIoTB2pJ0rS/Vx9q9bIcB10H5fRhlbq/V
         emgmVxQRBGmn3mzQSrYzVKAkLSn12Gr3CrcHNSg1OvtjGwlW91mhyZVf8yGUQu2M+L6y
         8sIA==
X-Gm-Message-State: AJIora9tW0KrwptcYOGeOJ8ZMN3MkX+mZamHu+Onbym+XEeooinSY31m
        6Ga8lt25Orl0hHOTHk5q4Hc=
X-Google-Smtp-Source: AGRyM1uddY6LgwKOTm5Ji22rWIffZn64NStLaReByHvTQu57KlxPYNzalWni1MTEMw8H2VUrSUhtPg==
X-Received: by 2002:a63:4042:0:b0:411:bbfe:e736 with SMTP id n63-20020a634042000000b00411bbfee736mr14888481pga.1.1659390180950;
        Mon, 01 Aug 2022 14:43:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902f14300b0016d5428f041sm9941638plb.199.2022.08.01.14.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 14:43:00 -0700 (PDT)
Message-ID: <a74ec294-9701-9842-bec3-84b624f8850a@acm.org>
Date:   Mon, 1 Aug 2022 14:42:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220729151301.v4.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <1ca16b27-21e5-3537-400a-25cdae52396e@acm.org>
 <CAONX=-eknyxTsM21gW6ruaCoov3oJB12g871Wmiq+ibDm4QZCA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAONX=-eknyxTsM21gW6ruaCoov3oJB12g871Wmiq+ibDm4QZCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 14:29, Daniil Lunev wrote:
>> Please change "can not / can be enabled" into "is not supported by the
>> host controller / is supported by the host controller".
>
> That would be incorrect. The "caps" variable semantics is a bit weird
> in the sense that it is used at times to convey "active" 
> capabilities, not just supported one. For example, for the 
> writebooster capability to be present in caps, first controller 
> driver should indicate it is ready to support it, then the part that 
> is attached to the host controller has to indicate support in the 
> device descriptor, then WB has to be configured and its lifetime
> should not be exhausted. If any of those parameters are not
> satisfied, the capability will be removed from the set despite 
> generally being supported. I am not sure how to properly word it, but
> just saying "controller supports it" would be counter-factual
> (especially since the controller doesn't really knows anything about
> writebooster per-se, it is part's functionality). What would be
> suggested wording in that case?
Given the above I think we can keep the current wording. This also makes 
me wonder why the UFSHCD_CAP_WB_EN flag occurs in the hba->caps member 
variable. That member variable is used to track controller capabilities. 
My understanding is that the WriteBooster functionality is a UFS device 
feature and also that no host controller support is required to control 
the WriteBooster feature.

Thanks,

Bart.
