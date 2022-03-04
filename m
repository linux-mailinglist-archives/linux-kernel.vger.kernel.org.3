Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F060B4CCD08
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiCDFXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiCDFXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:23:41 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BC2A277;
        Thu,  3 Mar 2022 21:22:53 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 6so2049244pgg.0;
        Thu, 03 Mar 2022 21:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUz+YHeOX2526f3yLcPlYSdunuzlqb7mEsolHTN6QCc=;
        b=TKGhxT1xQjOI9NiK5fFVY2Xrn5tNT2acTtC8M5brN33736eI3K9Ui3NL4wfrFmnh9e
         mroaJSygxTK+9hUq4MgFMd6BsAn/G5MTdRp5nlXgo62iRkkYPkbA5Ys0eMi4N3S0x2SM
         jsDUS2HfUIMiqtBh8/KZhqrUBHgHbSNhQX/s+BwxeATaRp17z9rv8Uf/lDZ757cNzdqI
         efnx83xHMgPTq7eHkOBcRq2P09zjrCIeqka/taN5gFSdgrDFilv9fTi7IP5Q6PpUUzEW
         jiBEnvmNlPYCgr0nTGSWswvBH/bkfhcumv9NZJHFq7E3ytvXbnEt2oErpGqZdKOIT+g5
         dy8Q==
X-Gm-Message-State: AOAM532larrWurJGNanoj3Fa5+5RoNPt3gieaMQgyk48CTAizDxUj42C
        r5G1bNNtmipqtg5cD7zLT6A=
X-Google-Smtp-Source: ABdhPJxYq0TQM9vFcm1Kh6j0fbxqoFm/wrv7nZEyjEvofCbrP3HT13X6zNV9QhK/eSCtlBdJzomxHA==
X-Received: by 2002:a63:4c07:0:b0:374:a41b:62e1 with SMTP id z7-20020a634c07000000b00374a41b62e1mr32490448pga.541.1646371373021;
        Thu, 03 Mar 2022 21:22:53 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b004f65b15b3a0sm4274787pfk.8.2022.03.03.21.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 21:22:52 -0800 (PST)
Message-ID: <e7e99791-aade-55fd-ac75-71478699cbe0@acm.org>
Date:   Thu, 3 Mar 2022 21:22:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Tom Rix <trix@redhat.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
 <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
 <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
 <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org>
 <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 15:38, Joe Perches wrote:
> One argument is that churn leads to difficulty in backporting
> fixes to older 'stable' versions.
> 
> I think the churn argument is overstated.

I'm often backporting patches to older kernels and I think the churn argument 
has not been emphasized enough. Backporting patches is a normal aspect of a 
product lifecycle since a kernel version is chosen when development of a 
product starts and bugfixes are cherry-picked from upstream selectively.

Thanks,

Bart.

