Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8041545586
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiFIUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:24:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A71CAC0A;
        Thu,  9 Jun 2022 13:24:47 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d128so10701937qkg.8;
        Thu, 09 Jun 2022 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/1JbKgANWf9n04u0SMFCJobkXYrPWds2jPiHBJaP02E=;
        b=OR8g7bXmEFsQ/q8M5dBJV4Rma7R+PZ4UFnfI/3Q6uO37UgyF1wh6SxxKMA83jB2Sbr
         2CNJRrsezAFVRjY/94pLKD1uVDgkqRk4xax9JUagey3H5LIYYL4Fz8RDmI7Nzzo8A2dV
         oxUnwfqwrUtgVueFm+UqkpyAtme4gUg+yUnK00SO5JIRm6jXgT+20FdyGMv6qRb9yAN3
         hrU0MNYLv0vroQ4jPXNgeRv1NzLN+E9rFzuONF7uh/Iio+cGUQyOkxdoOPFFaAKXmLUl
         jXjGk3IRyL84lvuYwNWQgBk3171EoAYC6MKJN/PUUgyosvDMVVN/MAxI1e+LPjhep6jP
         kIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/1JbKgANWf9n04u0SMFCJobkXYrPWds2jPiHBJaP02E=;
        b=4ZslhKaFhGsognMVSEedOO71W9H2pcdjfMbKpUCNwo6vbBD6S6qvovjbrJDOoSe39w
         xz0/05lrDXKdpVWrH58Dh+Xtli8fIaQzwwwS4vc2Jxjb1FL8hZ5xno7gguatNT9yFwv6
         prJb6TOMvvGjOo+b5EX1y3Zc0wLUZ3pP4KKdlYEE5dY2PzBqCmUMSwGM5Hffa4HOJgRf
         xM+Rlsdj5B8+myGY7/oV1w2zOmA7eTb7COs0gACSeWMsK2eAdbPFACIjeESJbvqDQdRp
         DELJTHYyfazbx/avBAV1007mc29OUMbeVA6G+/GwfeyQ8B8W207Wc+SR86J/WWOapvGK
         whLA==
X-Gm-Message-State: AOAM532qwq9p3WbbGngyGGr0uvjcUhy+ZzaFiH6n1B7SehAx94yGToWI
        3gdcNayVM8KCjTGaDbk9f7aXI87+ap4=
X-Google-Smtp-Source: ABdhPJwKc6KGofN6lIiryk5XRjvxUT1QNenY2aeSDiaba45lr73Ne23TXf7L7pbOv2FtkpYpZqYTwQ==
X-Received: by 2002:a05:622a:15cb:b0:304:c9a7:cee1 with SMTP id d11-20020a05622a15cb00b00304c9a7cee1mr32790417qty.594.1654806275939;
        Thu, 09 Jun 2022 13:24:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:6563:b714:ecb0:c5a1? ([2600:1700:2442:6db0:6563:b714:ecb0:c5a1])
        by smtp.gmail.com with ESMTPSA id x16-20020a05622a001000b002f39b99f69csm8865646qtw.54.2022.06.09.13.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:24:35 -0700 (PDT)
Message-ID: <60c2291e-6e74-1df1-692f-00d02f8a83cd@gmail.com>
Date:   Thu, 9 Jun 2022 15:24:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 00/16] ACPI: Get rid of the list of children in struct
 acpi_device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <YqINyDTfpNBGDYlb@smile.fi.intel.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YqINyDTfpNBGDYlb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 11:12, Andy Shevchenko wrote:
> On Thu, Jun 09, 2022 at 03:44:27PM +0200, Rafael J. Wysocki wrote:
>> Hi All,
>>
>> Confusingly enough, the ACPI subsystem stores the information on the given ACPI
>> device's children in two places: as the list of children in struct acpi_device
>> and (as a result of device registration) in the list of children in the embedded
>> struct device.
>>
>> These two lists agree with each other most of the time, but not always (like in
>> error paths in some cases), and the list of children in struct acpi_device is
>> not generally safe to use without locking.  In principle, it should always be
>> walked under acpi_device_lock, but in practice holding acpi_scan_lock is
>> sufficient for that too.  However, its users may not know whether or not
>> they operate under acpi_scan_lock and at least in some cases it is not accessed
>> in a safe way (note that ACPI devices may go away as a result of hot-remove,
> 
>> unlike OF nodes).
> 
> Hmm... Does it true for DT overlays? Not an expert in DT overlays, though,
> adding Rob and Frank.

DT nodes can be removed.  The devicetree code uses devtree_lock and of_mutex
as needed for protection.

-Frank

> 
>> For this reason, it is better to consolidate the code that needs to walk the
>> children of an ACPI device which is the purpose of this patch series.
>>
>> Overall, it switches over all of the users of the list of children in struct
>> acpi_device to using helpers based on the driver core's mechanics and finally
>> drops that list, but some extra cleanups are done on the way.
>>
>> Please refer to the patch changelogs for details.
> 
> I'm going to look the individual patches.
> 

