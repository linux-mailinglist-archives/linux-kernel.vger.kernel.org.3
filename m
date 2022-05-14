Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186365271E8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiENOVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiENOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0720A1B1;
        Sat, 14 May 2022 07:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8537360F2A;
        Sat, 14 May 2022 14:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8425FC340EE;
        Sat, 14 May 2022 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538067;
        bh=fBJG7A+XsQUdGt9z4Q/dgnY9axRvsRVkKDu5cKbiVRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pQqTcVRNOWdlHHOXC+4ME/GCYRzZnE8N7ttD47TT9CnJrMLVmTkjbLeWKpJQfeDhv
         B2s6QGQXfNzXSAyTatQdpt8RwvlURF0V0iC1OVvNyb6mfs8iQcydgDnUBQeAjQfUFG
         wRp1M52PJ3Y3DsWNx6TGCG1DposlLQ5GRCfW37nVU+4GUaHW2BoAvfJEle4Z6tLi5M
         EkaXY4LY3LdzMDOg+ZDkxoilOA2mt8cAc4rljnfawj23clTnGXYhUBuBWSXk1unGLk
         MUBg0K5zcwc22Hpg7igxdPA0VcDyMnHKMP2BmRVEHuc9RJp0a8cAIXywbAeagz6gSZ
         vR9sGgUex9UPw==
Date:   Sat, 14 May 2022 15:29:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: proximity: vl53l0x: Document
 optional supply and GPIO properties
Message-ID: <20220514152940.1a212c7f@jic23-huawei>
In-Reply-To: <f5ec4fd9-b9d7-10fa-1c27-2f268466274f@linaro.org>
References: <20220512191334.61804-1-markuss.broks@gmail.com>
        <20220512191334.61804-2-markuss.broks@gmail.com>
        <f5ec4fd9-b9d7-10fa-1c27-2f268466274f@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 10:56:50 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 12/05/2022 21:13, Markuss Broks wrote:
> > This patch adds the optional properties for the VL53L0X ToF sensor to the
> > device-tree binding.
> > 
> > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>  
> 
> Wait, two days and three versions? Please give some time before
> resending entire patchset.

Yeah, several instances of this on the IIO list this week. Please
let things sit for at least a few days between versions even if
the requested changes are fairly minor.

> 
> Same comments apply as for v2 and v3...
>
I 'could' fix this up, but given you've not responded to Krzysztof
I think I'd prefer you send a v5 in the second half of next week or
later (to give time for other review) with the patch description
change Krzysztof suggested made.

Code wise the series looks fine to me.

Jonathan



> 
> Best regards,
> Krzysztof

