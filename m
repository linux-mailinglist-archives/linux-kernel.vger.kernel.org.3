Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341F567107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGEO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiGEO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:28:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B21122;
        Tue,  5 Jul 2022 07:28:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so7372160wmb.1;
        Tue, 05 Jul 2022 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=EXGRsUwQV8pvCL3786uZw0zAn6EurTKPfXnceiDNHOg=;
        b=RITL+RwED/KE5IlUrS9wwoEoYkndhIaAJm7NNIo1bdNtKgyqBPH4m1ceJOG6CO4uoq
         w02d9O+i7I6dOCAIIFYCGcEUVbwV41GZrynCay8YOIO73ZeaGAF8uFGfnXRPntEN+Xfs
         ZUPR5EEuOzqbkkS8OoUKQ6OxKhywkKQTRToZqmG7BIUyE3hx9AGG/2+da6KJ6n3NwRCP
         zi+qVbUj8tzyA/ylYrUP8Y/+snBG6kMvRqnTftMg1sgbVyAM2iJpycUE3xiz3inYanh/
         mjdI9z73qWpwSXktH8FResKy8QZ+d7kR/rEsvhMBg/sk6J6Cxqr9Tvhll8kVaQuP7Qgh
         IL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=EXGRsUwQV8pvCL3786uZw0zAn6EurTKPfXnceiDNHOg=;
        b=zpw+vagDF3v1YsEdsf+yXxsiyJKnofn5N8tFSihllomMOBv4l4iiY40KUP324sP4j5
         hVXjCa6zweQNNIPKaQUGa/ReedCJJxt/gb8OFDAVYkUHp81zO7LWt17u4J+NpBTtj2Ob
         OOyYzWQ+bJfo6pUsBpqDEXQ04L0WuSvRkxP/C5/McTqr49tt0D31oO7q/FgQArFZdPZr
         dpvmd1ejJCsG8LbAXWA4ibZEOz/fOdPa79BBV9YGujuXdO9AWDdbO9oTOAMQ2bGe8beE
         n4FH4aEOgyO4IzZm1g9YC1jV1o6FW/ItNM3Cxz6A94AZkr6mQvUWAa2ZDkdqSFenKORE
         FMGw==
X-Gm-Message-State: AJIora9NpqQpwL9AhbEMNAAwRxcptK0tUEzfQEepYV3x9yNIgSQte40j
        M+C5CWuXn90SsXqMc0sK/J8=
X-Google-Smtp-Source: AGRyM1sGJ2QZk0b8/Vdrhrq+x/YHFQY1wrT7fYYTeW2gA0XPN5xJWZxYgHf1cRt0ML9q/4LugxeBEg==
X-Received: by 2002:a7b:ce8a:0:b0:3a1:8ead:2ae5 with SMTP id q10-20020a7bce8a000000b003a18ead2ae5mr23325867wmj.100.1657031319889;
        Tue, 05 Jul 2022 07:28:39 -0700 (PDT)
Received: from localhost (92.40.203.109.threembb.co.uk. [92.40.203.109])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b002185631adf0sm34394500wre.23.2022.07.05.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:28:39 -0700 (PDT)
References: <20220705115439.5a189cde@canb.auug.org.au>
 <YsQvbia3TXHe/CYS@google.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Date:   Tue, 05 Jul 2022 15:26:59 +0100
In-reply-to: <YsQvbia3TXHe/CYS@google.com>
Message-ID: <KkVMxAUKFH8DtV5pcfrzcMIPidvJj2Ei@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 05 Jul 2022, Stephen Rothwell wrote:
>
>> Hi all,
>> 
>> After merging the mfd tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>> 
>> drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer type 'int (*)(unsigned int,  int)' [-Werror=incompatible-pointer-types]
>>   634 |         .get_irq_reg            = axp192_get_irq_reg,
>>       |                                   ^~~~~~~~~~~~~~~~~~
>> drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_irq_chip.get_irq_reg')
>> 
>> Caused by commit
>> 
>>   8c7d8aa029a3 ("mfd: axp20x: Add support for AXP192")
>> 
>> I have used the mfd tree from next-20220704 for today.
>
> Aidan, what are your plans?

This is missing the prerequisite regmap-irq patches, sorry if it wasn't
clear from the cover letter.

Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
