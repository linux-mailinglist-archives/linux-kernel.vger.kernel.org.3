Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9185672AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiGEPbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGEPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:31:30 -0400
X-Greylist: delayed 281 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 08:31:29 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EF1A060
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:31:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AA1445801B5;
        Tue,  5 Jul 2022 11:26:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 05 Jul 2022 11:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657034804; x=1657035404; bh=MF
        i8fRqOqi18T3xvIbSvC10TcXRQnQ4IO47Q6dlyNuQ=; b=dY1JRJGrKxALkoibJt
        Tv0xwGUFfjxHxktHNZ34u9VFfrO3LwcwWXfw9bjlcj+6H3YYmu7dBWNFkV8bn6V5
        dK4mZM3don/cv/q7hAnvbNlPX8g88ugmqSby7BM4XIZ0zkMbNOxeCYskt+UzJ7dU
        h9Jn9hng4w4b7MRgWvZqk9Jp/Mubvu8OCHGLCNeYbFW2ap4+t7otan/hhnJ6AYGB
        cRLwHjy/VPsq+TCRcmD9hYOPawgZVuguC/1PnzcLqxztDnepLraZIir1Yv3kkZJa
        YmCvvihrAg4pYufOZfU3Ij9gK7BWias4LFe9p8MmJ3Tzftj1aRTWl64OFokSVqal
        58TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        ie3994620.fm2; t=1657034804; x=1657035404; bh=MFi8fRqOqi18T3xvIb
        SvC10TcXRQnQ4IO47Q6dlyNuQ=; b=I80vGBpKw8Higl2hJO+hNIqwNKMlnGUUKL
        f/Gr/3lRD7pzoF+wB7aMA2aXp3RMqh3ja8Pn6kaQfe0mfYf6St4LmqhnEeK2bs1R
        n6MdODpi8HNj5k+0p8H0ROJQ3w8j7etGSnTtwOpbiahFJWzgac1T212EiKVzbSia
        AkQ511PFtU8pR9luacoug50kkYPLOEx9Tc+x96OmC48fV7UEoEAR860WaaYytzMl
        n0lwWeN5Z8WhMt/Z4N78B66HFaNj3Y+qc5D9StnaKwNNx0/iaGZbqwyfD9I2b0cI
        embM7unKaOZPq62wPBYffM4ffn4f4IvjjGbS7/FSr9SVTN+c1c8A==
X-ME-Sender: <xms:M1jEYqyyUy2nbaSxsikk4fwKDD3byImfr9oGARsKBK-R3E0PzTZRSg>
    <xme:M1jEYmS3r6WFcAr6cFnm3be9W5orzqVi4QDMgIFQc6q1TJByIOuC64RNX-nukCN3c
    pzp6hpYP0m-UOmfJ50>
X-ME-Received: <xmr:M1jEYsVFJSo8xYp-UEO4nvsVuj3dMFZhpIXmD_Ai97q6vxeug2refHYtLVzY9eTn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrghssehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:M1jEYggfDdvSzFlPqwpNqtu46JCuU3lk5dmfdufJv_KjceMGp_4xYA>
    <xmx:M1jEYsAqG9aIwqFFIzNoNIKeWUsu5LhHaHb6hGZapXvgMd4G9Jy7rw>
    <xmx:M1jEYhJQ4PtbZKxQrICnyPStXGUw6TWgGYm7w_Ha3-nI_ZjTx6kGOw>
    <xmx:NFjEYs27wBQHZBggzzh6KqPQPKTds5smaDvlCBvq28qc_BykOMkssoG84zA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 11:26:43 -0400 (EDT)
Received: by shutemov.name (Postfix, from userid 1000)
        id AD6E3103BA0; Tue,  5 Jul 2022 18:29:10 +0300 (+03)
Date:   Tue, 5 Jul 2022 18:29:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Message-ID: <20220705152910.rq2ga25gnw7kuvt5@box.shutemov.name>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
 <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
 <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
 <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:15:21PM +1200, Kai Huang wrote:
> 
> > 
> > I still don't like the idea of using the DMA API itself.  But, maybe we
> > need some common infrastructure that the DMA API and this code use which
> > says, "get me some pages that I can safely make shared".
> 
> Right.  For instance any KVM PV feature would require shared memory, and DMA API
> normally doesn't fit (taking 'struct kvm_steal_time' as example).
> 
> Maybe we can reserve a CMA for this purpose.

CMA for couple low traffic users sounds like an overkill. It will create
an separate pool just for them.

I think the best way is to add an dummy device and couple of helpers
around DMA API that would allow to tap into swiotlb.

Maybe hide it inside CC infrastructure. Like cc_decrypted_alloc() and
cc_decrypted_free().

-- 
 Kirill A. Shutemov
