Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7051F4F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiEIHFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiEIGvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:51:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941A815A3F5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:47:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e5so11238258pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+O2wWIYtSN6v7D3S7HE43AVtnFz4Fs9gpTHjGdIAXw=;
        b=CUJD3MGxQAYTxanRS7RRy74vpVXIeCRYmEdhWDRMPZvHt5RsJQJ9hSjWBYftdA6WYo
         XHgX/WXibp+3rMcavpaO63pgoqCAtpvnI4pSinQ1hQw9iEDB12co5iR8TDckzT+1Ir2i
         MdEOUh7N3Ufhy0Se3m+kBvF4a8A8ZvYTP68yMvOd4u5+1XNJlAYcpY3CTQFZMzB6NlN0
         onh14jDg3iHYft88hVA5HzlZkvVxYt6j1pFXj92Cjxlx8/Tk47p/dF3Hhb2tCc2Dvupv
         KOL0wWCFFCleYu0k6KRIqYb2uFHl1YvedkWiWbb2Nr2Uy5fJClzoLSSfg5KC5R8QFdbx
         M2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+O2wWIYtSN6v7D3S7HE43AVtnFz4Fs9gpTHjGdIAXw=;
        b=VJqqZ+9+N1zxoMb0phnlUoxkAay/g7VcO3PbQbt9RGzrousKmnDIKXEOen1Ee2Yn/M
         KREsC39PqHFjbaX7U4384Or+tXoxGPDWnN+qQYlr5uk328lolZCpw4mGP7YR97XONO9G
         JbkrKZmFhb0iE5bghKAXNLcXk00fXDi8SHwZgHpIs1DYChkEqMxoL4nBYNzMSBBl1WQM
         hJTKY8NJNAjcEmEMEszgQeYzMEtxuh9rMr4KmfpJScRLe1pjNeTXEMr3fAGPCg1PIcUl
         C/88JMDd+jI4xe989LVuTkTXngxoFP72j4WgkkRF/Pw+TTQfFFrEarEWSJkd9bgSgGiJ
         h1bA==
X-Gm-Message-State: AOAM5320a3RVUCQ8ttmNoJ830B47TMwNJjxOXCLtmobLBiQaPSeRgRDj
        BY147DYppTbwfix245aHmBEpc7UWz2nrT+PegTbQlg==
X-Google-Smtp-Source: ABdhPJzeywHjNPgQ2e8+81H3HxjJ5160+Mo9DrU73UpmHrLc0o39xzUzzFM8Zj7+8U49t8aaXxSFYLrk6xvGEzi9l8g=
X-Received: by 2002:a63:f4e:0:b0:382:1e31:79e8 with SMTP id
 14-20020a630f4e000000b003821e3179e8mr12395833pgp.167.1652078860816; Sun, 08
 May 2022 23:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220502104144.91806-1-manivannan.sadhasivam@linaro.org>
 <20220502104144.91806-6-manivannan.sadhasivam@linaro.org> <CAMZdPi_i60TqszUL+=ocMn-4veyoGRQoOGD_B4YiEpz_uWE+ZQ@mail.gmail.com>
 <20220504081720.GB5446@thinkpad> <CAMZdPi9oA4SSYGSPw9tCmQ=GhwhCgdYz+=rQiUzu1tNbo80ceQ@mail.gmail.com>
 <20220504155855.GA3507@thinkpad> <514326aa-49eb-2b07-b99e-53899722c7e2@quicinc.com>
 <c9ac9fbf-d94e-feea-e762-95eeae8f5a74@quicinc.com>
In-Reply-To: <c9ac9fbf-d94e-feea-e762-95eeae8f5a74@quicinc.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 9 May 2022 08:47:06 +0200
Message-ID: <CAMZdPi_NwN_y7AQMu47NoFDFtgxoV8TPdRdxqm5+GmT0uUZh+g@mail.gmail.com>
Subject: Re: [PATCH 5/5] bus: mhi: host: Remove redundant dma_wmb() before ctx
 wp update
To:     Hemant Kumar <quic_hemantk@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_bbhatt@quicinc.com
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

Hi Hemant,

On Fri, 6 May 2022 at 20:02, Hemant Kumar <quic_hemantk@quicinc.com> wrote:
>
> Hi Loic,
>
> On 5/6/2022 10:41 AM, Hemant Kumar wrote:
> > Hi Loic,
> >
> > On 5/4/2022 8:58 AM, Manivannan Sadhasivam wrote:
> >> On Wed, May 04, 2022 at 11:25:33AM +0200, Loic Poulain wrote:
> >>> On Wed, 4 May 2022 at 10:17, Manivannan Sadhasivam
> >>> <manivannan.sadhasivam@linaro.org>  wrote:
> >>>> Hi Loic,
> >>>>
> >>>> On Wed, May 04, 2022 at 09:21:20AM +0200, Loic Poulain wrote:
> >>>>> Hi Mani,
> >>>>>
> >>>>> On Mon, 2 May 2022 at 12:42, Manivannan Sadhasivam
> >>>>> <manivannan.sadhasivam@linaro.org>  wrote:
> >>>>>> The endpoint device will only read the context wp when the host rings
> >>>>>> the doorbell.
> >>>>> Are we sure about this statement? what if we update ctxt_wp while the
> >>>>> device is still processing the previous ring? is it going to continue
> >>>>> processing the new ctxt_wp or wait for a new doorbell interrupt? what
> >>>>> about burst mode in which we don't ring at all (ring_db is no-op)?
> >>>>>
> >>>> Good point. I think my statement was misleading. But still this scenario won't
> >>>> happen as per my undestanding. Please see below.
> >>>>
> >>>>>> And moreover the doorbell write is using writel(). This
> >>>>>> guarantess that the prior writes will be completed before ringing
> >>>>>> doorbell.
> >>>>> Yes but the barrier is to ensure that descriptor/ring content is
> >>>>> updated before we actually pass it to device ownership, it's not about
> >>>>> ordering with the doorbell write, but the memory coherent ones.
> >>>>>
> >>>> I see a clear data dependency between writing the ring element and updating the
> >>>> context pointer. For instance,
> >>>>
> >>>> ```
> >>>> struct mhi_ring_element *mhi_tre;
> >>>>
> >>>> mhi_tre = ring->wp;
> >>>> /* Populate mhi_tre */
> >>>> ...
> >>>>
> >>>> /* Increment wp */
> >>>> ring->wp += el_size;
> >>>>
> >>>> /* Update ctx wp */
> >>>> ring->ctx_wp = ring->iommu_base + (ring->wp - ring->base);
> >>>> ```
> >>>>
> >>>> This is analogous to:
> >>>>
> >>>> ```
> >>>> Read PTR A;
> >>>> Update PTR A;
> >>>> Increment PTR A;
> >>>> Write PTR A to PTR B;
> >>>> ```
> >>> Interesting point, but shouldn't it be more correct to translate it as:
> >>>
> >>> 1. Write PTR A to PTR B (mhi_tre);
> >>> 2. Update PTR B DATA;
> >>> 3. Increment PTR A;
> >>> 4. Write PTR A to PTR C;
> >>>
> >>> In that case, it looks like line 2. has no ordering constraint with 3.
> >>> & 4? whereas the following guarantee it:
> >>>
> >>> 1. Write PTR A to PTR B (mhi_tre);
> >>> 2. Update PTR B DATA;
> >>> 3. Increment PTR A;
> >>> dma_wmb()
> >>> 4. Write PTR A to PTR C;
> >>>
> >>> To be honest, compiler optimization is beyond my knowledge, so I don't
> >>> know if a specific compiler arch/version could be able to mess up the
> >>> sequence or not. But this pattern is really close to what is described
> >>> for dma_wmb() usage in Documentation/memory-barriers.txt. That's why I
> >>> challenged this change and would be conservative, keeping the explicit
> >>> barrier.
> >>>
> >> Hmm. Since I was reading the memory model and going through the MHI code, I
> >> _thought_ that this dma_wmb() is redundant. But I missed the fact that the
> >> updating to memory pointed by "wp" happens implicitly via a pointer. So that
> >> won't qualify as a direct dependency.
> >>
> >>>> Here, because of the data dependency due to "ring->wp", the CPU or compiler
> >>>> won't be ordering the instructions. I think that's one of the reason we never
> >>>> hit any issue due to this.
> >>> You may be right here about the implicit ordering guarantee... So if
> >>> you're sure, I think it would deserve an inline comment to explain why
> >>> we don't need a memory barrier as in the 'usual' dma descriptor update
> >>> sequences.
> >>>
> >> I think the barrier makes sense now. Sorry for the confusion and thanks for the
> >> explanations.
> >>
> >> Thanks,
> >> Mani
> >>
> >>> Loic
> >
> > You made a good point. After following your conversation, in case of
> > burst mode is enabled and currently
> >
> > we are in polling mode, does it make sense to move dma_wmb after
> > updating channel WP context ?
> >
> > DB ring is going to get skipped when we are in pilling mode.
> >
> > instead of dma_wmb();
> > *ring->ctxt_wp  =  cpu_to_le64(db);
> >
> > *ring->ctxt_wp  =  cpu_to_le64(db); dma_wmb();
> >
> > Thanks,
> > Hemant
> >
> i think i spoke too fast. I think we dont need to worry about the
> polling mode as the context_wp update would happen at some point of time
> and that does not require dma_wmb after update context wp.

Exactly. It's also important to remember that a barrier only ensures
operations ordering and not committing.

Regards,
Loic
