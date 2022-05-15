Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F50527879
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiEOPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiEOPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:30:10 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044E1262C;
        Sun, 15 May 2022 08:30:08 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 27B293F653;
        Sun, 15 May 2022 17:30:06 +0200 (CEST)
Date:   Sun, 15 May 2022 17:30:04 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: adc: qcom-spmi-adc5: Add missing
 VCOIN/AMUX_THM3/GPIO# channels
Message-ID: <20220515153004.iniplpuf6g5ibvjw@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
 <20220511220613.1015472-5-marijn.suijten@somainline.org>
 <20220514171312.227a1f07@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514171312.227a1f07@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-14 17:13:12, Jonathan Cameron wrote:
> On Thu, 12 May 2022 00:06:10 +0200
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > These channels are specified in downstream kernels [1] and actively used
> > by ie. the Sony Seine platform on the SM6125 SoC.
> 
> Looking at the links, some of them are on that platform but not all.
> Better to make that explicit in this description.

This has already been queued up for v2.  Adding these seemed easy at the
time but they are in fact not used, and I ended up sending the wrong
patch.

Just so that we're on the same page: only ADC5_AMUX_THM3 and
ADC5_GPIO2_100K_PU are unused by my platform.  It seems the first should
be dropped, but the latter can probably stay in the patch with an
explicit mention.  If you think both should stay, there are a bunch more
channels defined in the downstream kernel as per [1] and I'm not sure if
all should be added for completeness.

> > 
> > [1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> I'm not keen on patches with no context being
> sent to mailing lists. Please cc all lists (and preferably individuals)
> on at least the cover letter so we can see overall discussion.

That can be attributed to the terrible workflow for sending
patch-series.  Somehow only `git send-email` supports --cc-cmd yet I'd
expect it on `git format-patch` for auditing and possibly copying to the
cover letter, if `git format-patch --cover-letter` couldn't do this from
the beginning.
At the same time `git send-email` has --[to/cc]-cover options to
propagate email addresses from the cover letter to all the individual
patch-replies, but not the inverse :(

In the end this leaves me manually running get_maintainer.pl over the
entire formatted patch-series, and manually copy-pasting + editing the
addresses into the cover letter... Which is easy to forget and is no
different here.

My apologies for (yet again) accidentally not sending at least the cover
letter to everyone.  That's a gross oversight, and I'm probably - no, I
must - be doing something wrong.  Suggestions and/or documentation
references are welcome.

> If nothing else, I've no idea if intent is that the patches go through different
> trees or all need to merge via one route.

I have no idea either, and have not yet had an answer to a similar
question on a different list.  Usually it seems the maintainers work out
amongst themselves who picks what patch, putting them on hold where
necessary to preseve ordering.  If not, should the sender split patches
across multiple series, either holding off sending part of it or linking
to a dependent series?

In this particular case DT has to wait for these driver patches to land,
otherwise they may define channels that do not exist and unnecessarily
fail probe.

> Patch itself looks fine,

Thanks.

Looking forward to your suggestions and answers,

- Marijn

> [..]
