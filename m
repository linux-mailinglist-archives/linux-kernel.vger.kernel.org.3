Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC25612DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiF3HBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiF3HBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:01:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C836697
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:01:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v185so22618036ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MAZhSdNJo3QokCNWF16iPYG6xcDRmv0nRT3AeZjRHk=;
        b=d1872KUv97LdlFmqqlKYeSNxhGag05R6wVXr96rFIwqSnSEjzF4+E6vhbBZc3Ksi2b
         ihHpXQRBkpuz7GcmAfaO1eEr6TO4q6GWRWWmQwb292nav8hK8D8mOZGISeHd0EUA37Ga
         5IwnDj8e4pVcnBpQDsn/COi2WlrE3RuGCe9HnYftNMq4rizOw6mEI0eK08z+kKvQ8hde
         HoyQX5HNqxNU65sIhc5TAvpG4QqC7AcrkcxJifPIiKFk2iZflZVWzRhtSV0trmh2L2Yn
         JS2WkLDqdnxC68huw33b55uU2tdepqzGCSDO84Vz0xoDYoPNVm61QInmJ89OzWXIH9mr
         9nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MAZhSdNJo3QokCNWF16iPYG6xcDRmv0nRT3AeZjRHk=;
        b=uk8KCtbj7kRHOFcgP+eNfv0Y/xR8atr7wUt7yupuAzmvwrAyBq916c/+1X1/Ocgrsn
         vQNhR7Hm1Avm1xTjk32LoXxvxfOWx8qe5/mMfOUB2G49WxR2b/Amb3BX/6iQjf+iy+GQ
         ZHTKuBNDSkIsoDjwldXib6LTxY0a+U3y101JUUlNxU0OXXnn4fYiXL9E4fIC/iIwqUFj
         KEqHzjzsWS/1iwBlqh3PeY32VRfdCxRV57cxkhfOsV6uNyQUyKj2yN+2aZN7MbXQ34Op
         PLiLrfcqiHcYVDAFzb5ufZXbUIvMJ0e3I09toVvCnSPbJlED+8BCb7PcSAaDaNvQ/DJO
         s5QA==
X-Gm-Message-State: AJIora8a7SCeLoIv4hwkh9tl4FUixA45UNq56oxOqWiOy+1cxRhdmvJ9
        /YppBKgmkAZLJmliz/7ZO7QRoROpT6nh6jCCYdV48g==
X-Google-Smtp-Source: AGRyM1tI8AU9DaGXxeIyzotuiun7FqolJenmEF9ES7RUXabvemB9RjBSPIJMc0Jn7NjK0uYgCL/0rTZdFzpLFDbTzgc=
X-Received: by 2002:a05:6902:1501:b0:66d:2ae0:46b5 with SMTP id
 q1-20020a056902150100b0066d2ae046b5mr8039359ybu.225.1656572477270; Thu, 30
 Jun 2022 00:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
 <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
 <409fc8d0-119a-3358-0fc5-99a786a9564a@huawei.com> <20220627105954.GA7670@vingu-book>
 <BYAPR02MB44881D68479406679935EDAA94BB9@BYAPR02MB4488.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44881D68479406679935EDAA94BB9@BYAPR02MB4488.namprd02.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Jun 2022 09:01:06 +0200
Message-ID: <CAKfTPtDyzBHtJ7ZFoXXDgBo721QsfR9m7FR4KaEn34EjoE2GhQ@mail.gmail.com>
Subject: Re: Perf regression from scheduler load_balance rework in 5.5?
To:     David Chen <david.chen@nutanix.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, 29 Jun 2022 at 23:45, David Chen <david.chen@nutanix.com> wrote:
>
>
[...]

>
> Hi,
>
> I applied the patch on top of 5.10 and also enabled CONFIG_IRQ_TIME_ACCOUNTING.
> And it did fix the issue I had.

Thanks for testing. I'm going to prepare a patch

Vincent
>
> Thanks,
> David
