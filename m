Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA85AAADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiIBJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiIBJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:04:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91C1057F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:04:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so970602qtv.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A0lRx9LcG2f6vdkkySTxdBxFyRczSLUlrhv0k8CVfMQ=;
        b=PqG6a4MKk2roT2Ce/PJEt8kCVddWYbqLQh141ATH+SE8SYCKK/ZFS9/OCHdfbfSgP8
         mQREKuMuSelAb6SBLEEu74TKUjSBBmwZ8WjygarTrIA/KvHYGyMp8a2J70T92Jg3Pcrb
         kcjEtRkQqjOXCQllUJDzs4CbTXcsIuMEFmKFSormg00PlTnX1F1InK7vkFbhfO4twbjw
         wX8s3+vO/eXcBlAlq1ZPFwMRXYokbFEoLvKUt2HuPvjJ+iL9BHtDGUWj4Z7VTMBrr1UC
         L7HTZSBcu84jPm1mYMiEOrw0O3Q0JaNpk4QrVKItYAbCjz/FlYGhDCg+mGNEqLY5iH3A
         0oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A0lRx9LcG2f6vdkkySTxdBxFyRczSLUlrhv0k8CVfMQ=;
        b=OddTsxKWlZVwlZaO+UZXNq+LjKgLLjZ3zuicp5+w+OoOS2izx1kwHTgPTBj0UWRm8G
         tfmVxgoWAOaV7mK5FQGLCoqemHkYfRzYMfdmifrin+ZchRwtAwrRSsr0iGndI2tTUVRn
         jOHmqAbccRbHCBJNNEab21PnDB3YYi5T/UzxwFF86g4UBE78fT1bLgUE1LQcp08Fsn/c
         Fnb+r4T1XhOdLegskFhWmvBMzd8eTkvHa9Pg4z+rKzC7xemI0yYEMNcwdSHJ+CsC5Fol
         ySOieGgd74HA0nBZLlEKp8v7nI4uAIpx07hnsrFVBiTd6czJNAhhwJfGVlHFguTmgZLt
         08gg==
X-Gm-Message-State: ACgBeo1FRElTGUwwAKhDbdmi8VEr+asNP0A9KTTybwEhcoTAepfbru/v
        GPhcHlnQNkvdddayCyPatMIAQOTqMRqHANL1iks=
X-Google-Smtp-Source: AA6agR7C4/X8eo8OV4IEGqRGWP09L1le/kpVLIzKikXVS/h8SIICiTqB0VGNInh/3lWYFp6j5asmpgMaMlwtPWel10o=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr26659521qte.195.1662109495202; Fri, 02
 Sep 2022 02:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220901175022.334824-1-cezary.rojewski@intel.com>
 <20220901175022.334824-2-cezary.rojewski@intel.com> <CAHp75VfO7_ASHGdpkcb1dwvhyHPT31eYuAkCm2q7B+2WmtZC4g@mail.gmail.com>
 <e8a06f76-9414-6391-0582-667cf817dbcc@intel.com>
In-Reply-To: <e8a06f76-9414-6391-0582-667cf817dbcc@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 12:04:19 +0300
Message-ID: <CAHp75VdCwJMSzVD0_tniFOwshR-5mJqgwL58=aV99XFXgK5Obw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/string_helpers: Introduce tokenize_user_input()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 10:46 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
> On 2022-09-01 9:34 PM, Andy Shevchenko wrote:
> > On Thu, Sep 1, 2022 at 8:40 PM Cezary Rojewski
> > <cezary.rojewski@intel.com> wrote:

...

> >> +int tokenize_user_input(const char __user *from, size_t count, int **tkns);
> >
> > Not sure how I can deduct from the name what function is actually
> > doing. Suggested new name: int_array_parse_user().
> >
> > int int_array_parse_user(const char __user *from, size_t count, int **array);
> >
> > (Note that we have _user suffix for many APIs in the kernel that does
> > interact with user space memory)
>
> That's why I've added '_user_' in the middle! Anyway, I guess the
> expectation is that it's a suffix - precisely at the end of the name.
>
> Could we reorder it a bit: "parse_int_array_user"?

Most of the exported functions that have 'parse' word, have it after
namespace, but in this case there is no dedicated namespace and it
also will be in alignment with parse_options_str. That said, go for
it.

-- 
With Best Regards,
Andy Shevchenko
