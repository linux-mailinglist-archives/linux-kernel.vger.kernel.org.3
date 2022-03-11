Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB614D6570
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiCKP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiCKP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:57:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297714A6E2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:56:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j26so13619451wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBab81rlsXVfIrb1h5ugmlXAnmE0dZk087QNoq8lEw4=;
        b=usv/7QYbADl2R0gma2J6J5sYrjRw4TDBnKEeY2m5BrJxInoEh23dkuXQowKqQZwUi1
         fVqYVr9Z//li8WbUkitTqPkn/gaJv6nhYvMmT7qz0ovfQeb4JJCjKxdHkPX4ea44XVl/
         YqyoH8eyNpliPfG06CzQsl2zZKyOfoe/6lL7NbLo2gaAy0/md4nK3MJXE8mcE0GkO8Z/
         LyY3KFqx/85OFkBU+Svo/0OIxh8wEOknlbdYWOr94y+CRto3VjCdPgc4oZkzgP31La6C
         Og/51kAY3M1RIkN9ZoUJv3xB2OWzN6p7tXyAaiAI2damReBHdb6p9lGOCyyBarml2Tal
         kvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBab81rlsXVfIrb1h5ugmlXAnmE0dZk087QNoq8lEw4=;
        b=OcukiM/VVS6wDzQIgtqRE+qeWOhNqGxLLDLV3IPac5SBCYdomHvlpf4raYQJKrDYtP
         LbxUBepOJxmNV+vBhqnQUOnsZBC+10fTLBK+jivKFcyXAKxcx3II9425g/aYEak8irwB
         NwUz+kLc0tXuYt3ulk3pZjJyMXOrPKigkPxtFFUA8pp6xXfPST7bFxr5NTipw0gPnnYp
         9GUT8W6OOk3+BJUPrRWPOorciRBIU2dTadO6rknbQ1gAPi2YvW7EMl0oe2vbOWX58Y7X
         9c5pBqqFnTwxZTqJpgnfkOGluWNbEFsPbwYX0vfjVifKqGCTbLb+4DUz1R3NfVphj0lM
         cmfw==
X-Gm-Message-State: AOAM533PR80+TUiF77DH2wTSulVNUXe90soToycMbvvISHmkEHidyCUq
        ht4G27lQaI82Corc1j/B8tf46IKAZoSmtM7DaAgiMQ==
X-Google-Smtp-Source: ABdhPJyHRl575oJ/E1f/YImGvu+xA6j3CfpVKm2dTU3ZrtKOXYSGHQkH5/l443BVjYhYSzAzYaAurPGVf+bw/uab3is=
X-Received: by 2002:a5d:4a8f:0:b0:1f0:4af2:4e29 with SMTP id
 o15-20020a5d4a8f000000b001f04af24e29mr7798876wrq.519.1647014165262; Fri, 11
 Mar 2022 07:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-2-james.clark@arm.com>
 <b3545a88-4743-db95-4676-b0b193cbea78@arm.com> <CAJ9a7Vi584BcY49TaRn5CJT=wcpafMf-3cA0R+sZ54p6iUKmeQ@mail.gmail.com>
 <7fae6630-fdec-3f95-9eac-3f7a5c789272@arm.com>
In-Reply-To: <7fae6630-fdec-3f95-9eac-3f7a5c789272@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Mar 2022 15:56:00 +0000
Message-ID: <CAJ9a7VjTJ4E7=qdPgfTTVjoW01rCzd-f1mFYHjtA3BHk25saMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] coresight: Add config flag to enable branch broadcast
To:     James Clark <James.Clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, 11 Mar 2022 at 14:58, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 02/02/2022 20:25, Mike Leach wrote:
> > Hi James, Suzuki
> >
> > On Fri, 28 Jan 2022 at 11:19, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 13/01/2022 09:10, James Clark wrote:
> >>> When enabled, all taken branch addresses are output, even if the branch
> >>> was because of a direct branch instruction. This enables reconstruction
> >>> of the program flow without having access to the memory image of the
> >>> code being executed.
> >>>
> >>> Use bit 8 for the config option which would be the correct bit for
> >>> programming ETMv3. Although branch broadcast can't be enabled on ETMv3
> >>> because it's not in the define ETM3X_SUPPORTED_OPTIONS, using the
> >>> correct bit might help prevent future collisions or allow it to be
> >>> enabled if needed.
> >>>
> >>> Signed-off-by: James Clark <james.clark@arm.com>
> >>> ---
> >>>   drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
> >>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
> >>>   include/linux/coresight-pmu.h                      |  2 ++
> >>>   3 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> index c039b6ae206f..43bbd5dc3d3b 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> @@ -52,6 +52,7 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> >>>    * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
> >>>    * now take them as general formats and apply on all ETMs.
> >>>    */
> >>> +PMU_FORMAT_ATTR(branch_broadcast, "config:"__stringify(ETM_OPT_BRANCH_BROADCAST));
> >>>   PMU_FORMAT_ATTR(cycacc,             "config:" __stringify(ETM_OPT_CYCACC));
> >>>   /* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
> >>>   PMU_FORMAT_ATTR(contextid1, "config:" __stringify(ETM_OPT_CTXTID));
> >>> @@ -97,6 +98,7 @@ static struct attribute *etm_config_formats_attr[] = {
> >>>       &format_attr_sinkid.attr,
> >>>       &format_attr_preset.attr,
> >>>       &format_attr_configid.attr,
> >>> +     &format_attr_branch_broadcast.attr,
> >>
> >> Does it make sense to hide the option if the bb is not supported ? I
> >> guess it will be tricky as we don't track the common feature set. So,
> >> that said...
> >>
> >>>       NULL,
> >>>   };
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>> index bf18128cf5de..04669ecc0efa 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>> @@ -692,6 +692,16 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>>               ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
> >>>       }
> >>>
> >>> +     /* branch broadcast - enable if selected and supported */
> >>> +     if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
> >>> +             if (!drvdata->trcbb) {
> >>> +                     ret = -EINVAL;
> >>
> >> Should we fail here ? We could simply ignore this and generate the trace
> >> normally. This would work on a big.LITTLE system with one set missing
> >> the branch broadcast, while the others support.
> >>
> >> Mike,
> >>
> >> Does this affect the trace decoding ? As such the OpenCSD should be able
> >> to decode the packets as they appear in the stream. Correct ?
> >>
> >
> > Depends on what you mean by affect the trace decoding!
> > From the simplest perspective - no - there is no issue as the packets
> > will be decode as seen. THE decoder does not know that BB exists - nor
> > if it is enabled.
> >
> > However, the reason that a user may engage BB is that the code is in
> > some way self modifying - so that following the code static image and
> > calculating addresses will result in a different path taken.
> >
> > e.g. imagine an opcode:-
> >
> > B <address0>
> >
> > Without BB, this will trace as a single E atom, the decoder will
> > calculate address0 from the opcode in the static image and continue
> > from there as the next trace address.
> >
> > Now look at the case where this is changed on the fly to
> >
> > B <address1>
> >
> > With BB, This will trace to
> > E
> > TGT_ADDR<address1>
> >
> > The decoder will initially  extract address0 from the static image,
> > but the immediately following target address packet will alter the
> > next address traced to address1
> > This is why we have BB.
> >
> >  So if the user has a reason to engage BB - we should really fail if
> > it is not present - as the outcome of the trace can be affected.
>
> Hi Mike,
>
> Now I'm starting to wonder if it's best to have some kind of non-binary
> image mode for BB where you'd just get a list of addresses output by
> perf script and it doesn't attempt to do any lookups.

Not at all sure what you mean by this

Mike

>  Although I think
> that would require a change in OpenCSD if it's not aware of the mode?
>
> I also need to go back to my JVM profiling test and see what's
> going on again. But I think I understand your points a bit more now.
>
> Thanks
> James
>
> >
> >> Suzuki
> >>
> >>
> >>> +                     goto out;
> >>> +             } else {
> >>> +                     config->cfg |= BIT(ETM4_CFG_BIT_BB);
> >>> +             }
> >>> +     }
> >>> +
> >>>   out:
> >>>       return ret;
> >>>   }
> >>> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> >>> index 4ac5c081af93..6c2fd6cc5a98 100644
> >>> --- a/include/linux/coresight-pmu.h
> >>> +++ b/include/linux/coresight-pmu.h
> >>> @@ -18,6 +18,7 @@
> >>>    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> >>>    * directly use below macros as config bits.
> >>>    */
> >>> +#define ETM_OPT_BRANCH_BROADCAST 8
> >>>   #define ETM_OPT_CYCACC              12
> >>>   #define ETM_OPT_CTXTID              14
> >>>   #define ETM_OPT_CTXTID2             15
> >>> @@ -25,6 +26,7 @@
> >>>   #define ETM_OPT_RETSTK              29
> >>>
> >>>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> >>> +#define ETM4_CFG_BIT_BB         3
> >>>   #define ETM4_CFG_BIT_CYCACC 4
> >>>   #define ETM4_CFG_BIT_CTXTID 6
> >>>   #define ETM4_CFG_BIT_VMID   7
> >>
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
