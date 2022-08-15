Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7776559342D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiHORt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHORt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:49:57 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A14286DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:49:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0BEAE3200988;
        Mon, 15 Aug 2022 13:49:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 13:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660585792; x=1660672192; bh=QE
        4xvdOORCkc8PPrFCkYq5enDGn2qK9OQMp2lhKzGVQ=; b=mya5ACVAN5qT1X/W2Y
        jCCqH/1im6kdrTA0XtFs7BsDwRSJZVnqwqgmI5qVlHIA8UtkjKabCOCa5lhPJYVp
        cQzDGJXPGQSPV7oYBGxN1C2RP4idlT5u/OpFNSQz+HdRp4jD4T9gGbp/Vl1/ikaM
        fgUGY5dfVMLcvEQiDk/2rctR603ExhV/rf5GVmOF5Z/602Ce6w/OhtJt/qcUitt7
        dnp16m2xbjDTMk+joZW1qjvP+IHc06WeHPhmwZeWx5jSqclX+n7Vkmuu/eeJIQXZ
        09CI+ejm7AZ9ZtzBRcbTkpT3S3YRp9rW7T2wOfljv+llG/P4MPtFlhGOtdVrDm52
        lSlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660585792; x=1660672192; bh=QE4xvdOORCkc8PPrFCkYq5enDGn2
        qK9OQMp2lhKzGVQ=; b=wsZILPh2C+viSRkVWCNxJy+im1EuErXftj+inD9bovx/
        F0fZ4Xz3VM/dUQEfx2xmepB0E+6sSd4JVPjcFUyWSlk0AP+zFxH8mU5ZHZF59wBP
        G0nRLpSk3GtiBg4nl17FyhgMNnJtUgN9VIfUDXAltHQzwJU1zggczvaiwwcawgcd
        XGQIVWKxMX0Qhmk7GgrewCSKrPHaiHytBHSuVRSrrPc5R1ZTFx3ENP1UK4S/JJrf
        MzCRxfL7qBkujlA1WT639L9F6uePB/2gvO7ximLVQeUO9ok8Wa+RKT73VuPxQsW6
        JsQ76sGfZ/NLsmFFMQ0rJwOXJbE/yOd6BOGHGWpAFg==
X-ME-Sender: <xms:P4f6YhEJ7P8AitfA7coWFoB_ToJ1z9V4KpHTbp_6pD426DKSVZtKxA>
    <xme:P4f6YmU-R2l0iatdwmzp9AV2hVzNB21DsknO2Ci7urhfIE1W7Foqd9DUkzG23dPN2
    _v4Hz-zEvc73WNvyNM>
X-ME-Received: <xmr:P4f6YjKn4Oec_UK0Iz11iyFV6acI33rlZTukGNNvqP-DPu-HyMp71LhVlfZ_SRxeNJ-5sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:P4f6YnGI2VNT7GjiOHS_Gyspw4YQcARcxED7cVg5Sj9RwhGTJO5Y3w>
    <xmx:P4f6YnVipCb3skWE5POsaO3AgWPFIrs8_IlECy1RiSBLAMg-mvqeKg>
    <xmx:P4f6YiOmNd93rKv7a0FXPLd6qEgC8NK9Nte8UtGgClMsJMZ-wzwJ7w>
    <xmx:QIf6Yov8b9bvLS4MPFolQw0pxzbZDH1p68097R0hPgAnohb-x4RFIQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 13:49:51 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D69D6104A4B; Mon, 15 Aug 2022 20:52:54 +0300 (+03)
Date:   Mon, 15 Aug 2022 20:52:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 06/11] x86/mm: Provide arch_prctl() interface for LAM
Message-ID: <20220815175254.jwogd3civiny6kas@box.shutemov.name>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-7-kirill.shutemov@linux.intel.com>
 <YvpMDOeVVKIzJhKV@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpMDOeVVKIzJhKV@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:37:16PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 07:17:58AM +0300, Kirill A. Shutemov wrote:
> 
> > +static void enable_lam_func(void *mm)
> > +{
> > +	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> > +	unsigned long lam_mask;
> > +	unsigned long cr3;
> > +
> > +	if (loaded_mm != mm)
> > +		return;
> > +
> > +	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
> > +
> > +	/* Update CR3 to get LAM active on the CPU */
> > +	cr3 = __read_cr3();
> > +	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
> > +	cr3 |= lam_mask;
> > +	write_cr3(cr3);
> > +	set_tlbstate_cr3_lam_mask(lam_mask);
> > +}
> > +
> > +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> > +{
> > +	int ret = 0;
> > +
> > +	if (!cpu_feature_enabled(X86_FEATURE_LAM))
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&mm->context.lock);
> > +
> > +	/* Already enabled? */
> > +	if (mm->context.lam_cr3_mask) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	if (!nr_bits) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	} else if (nr_bits <= 6) {
> > +		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
> > +		mm->context.untag_mask =  ~GENMASK(62, 57);
> > +	} else {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* Make lam_cr3_mask and untag_mask visible on other CPUs */
> > +	smp_mb();
> 
> smp_mb() doesn't make visible -- it is about ordering, what does it
> order against that the below on_each_cpu_mask() doesn't already take
> care of?

You are right it is redundant. I will drop it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
