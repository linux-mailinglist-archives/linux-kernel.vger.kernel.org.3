Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3724F8A55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiDGVyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiDGVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:54:29 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EFE1697B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:52:28 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id kr12-20020a17090b490c00b001cb3ee2e4c1so56649pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 14:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kWoriqwvAgVuYSUhi7L0THxaE1ScXOQjq9TtzmQJVbU=;
        b=pwAPb/14QX758nBfIx6MUnjCz3xSn8T1Z8Rwe+jnB13y5Ls+35/L/s+LoGYwACo4rQ
         6IiN6tF/r54StmmiCnuucP6sYc1IwQJdzzpbzjlUqEKmfRHozcSQkYiZIwYKzc8Q7e6/
         8VCnp9Bo6HT8pcHGRD+URlo8dFK9fnoR8lB6N1BjYhZM9VP2jiF9KVH+TGjLB5iaAGAY
         RmCVZ+3eWm0QwgkymJEC/5Yi7nURo1+3Ymi4bvb/9zO5tYLvD9/MEGX9cCAS4u5kXiFO
         e21Ul5F/LeV28F21gzUBCMafTLELJ9HJYsFLQKiW/jwT0KboofrMKmGx/DQ0BSuAmkNU
         grWQ==
X-Gm-Message-State: AOAM531ijY7T8Cj+kXeONUuk20klrJU+BEdImbC9zrImi0ZUuwZUJ4h5
        dttHksQeC7ScMwkB8LyWovQtxYGgqiVtdQ==
X-Google-Smtp-Source: ABdhPJx68cwpLQxSWHj/EY+iJVPBQu4+0qXEpeG0cd544c0QToBKKCAVi2UNtKrdsFxQvAYU4s2rRA==
X-Received: by 2002:a17:903:40c3:b0:156:ffaf:5d9e with SMTP id t3-20020a17090340c300b00156ffaf5d9emr6465312pld.134.1649368347628;
        Thu, 07 Apr 2022 14:52:27 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b005056a2a260bsm2765812pfb.129.2022.04.07.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 14:52:26 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Hsin-Yi Wang <hsinyi@google.com>,
        Tim Chang <jia-wei.chang@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
In-Reply-To: <CACb=7PUSAF6ui2a7iMYrrXo=v0OaXhCfiF=dPzq4cfUXM3JbDg@mail.gmail.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-3-jia-wei.chang@mediatek.com>
 <CACb=7PUSAF6ui2a7iMYrrXo=v0OaXhCfiF=dPzq4cfUXM3JbDg@mail.gmail.com>
Date:   Thu, 07 Apr 2022 14:52:25 -0700
Message-ID: <7h7d808sti.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@google.com> writes:

> On Mon, Mar 7, 2022 at 8:32 PM Tim Chang <jia-wei.chang@mediatek.com> wrote:
>>
>> This adds a devfreq driver for the Cache Coherent Interconnect (CCI) of
>> the Mediatek MT8183.
>>
>> On mt8183 the cci is supplied by the same regulator as the little cores.
>> The driver is notified when the regulator voltage changes (driven by
>> cpufreq) and adjusts the cci frequency to the maximum possible value.
>>
>> Add need_voltage_tracking variable to platforma data. if true, it
>> indicates soc is required to realize the voltage tracking between
>> voltage of sram and voltage of cci by software approach. otherwise, the
>> voltage tracking is realized by hardware appraoch.
>>
>> Add the notifier to cci so that it could react after svs driver changes
>> opp table of cci.
>>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>

[...]

>> +
>> +       passive_data = devm_kzalloc(cci_dev, sizeof(struct devfreq_passive_data), GFP_KERNEL);
>> +       if (!passive_data) {
>> +               ret = -ENOMEM;
>> +               goto out_remove_opp_table;
>> +       }
>> +
>> +       passive_data->parent_type = CPUFREQ_PARENT_DEV;
>
> It's better to add a note below commit message to state that this
> series depends on
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

Not only is this series dependent the previous series from Chanwoo, in
also fails to compile if CONFIG_DEVFREQ_GOV_PASSIVE is not enabled,
because CPUFREQ_PARENT_DEV defined inside of an #ifdef.

Please compile test this with and without CONFIG_DEVFREQ_GOV_PASSIVE
enabled.

Kevin
