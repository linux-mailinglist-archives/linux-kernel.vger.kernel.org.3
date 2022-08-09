Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E558DD80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiHIRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiHIRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:53:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E111CFCD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:53:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D0EEA5C01D4;
        Tue,  9 Aug 2022 13:53:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 13:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660067601; x=1660154001; bh=Vy
        KeV2ElkwgyDFVxUOxhmBbB09fpy5zZsNUAj88DvPA=; b=aJUDTZ0VtJDQz7PStj
        75K0dzSoUORG6XEpjvuRMT9WPyuAw1/DCqhwc+aA5BGVUyKFe9IMQMqnpJptgTC0
        XcfWtJWcYAVBF8KrIybWFdpIVFIYBMmDn/6H7lb/bPSwfeJES2LELUuwD3Ax1b7o
        QaOG7UF9r/0lFXixrTq+ImNPDfqXOTLJmMCvWrcec77SHD2/qbv4fuQVLyvChlKg
        5i00/PDeE0WyjOEjRbM6oebAim/mIB82/zuTvrZJto8JqbTK35K7h0R9H28y+bNV
        osbXtMM71YLFkXDWHsprEt4fgDFLIBuoXlLeduBUTkaqUkJa3eH6gSKTDwTHKRwV
        pKBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660067601; x=1660154001; bh=VyKeV2ElkwgyDFVxUOxhmBbB09fp
        y5zZsNUAj88DvPA=; b=ln3MRuCimKBs39Z9VwRE34fRbuCEHS6eoIYR6rDyyWfv
        u1Ya3MTlS4Dpq/q8rGR4YmGxu/VOAlqVtmDylo3jHKDJXq3AchN2i8nhTZRioCnB
        3+24MJ/muj7eNox1KUaGCsYuJLd2vMiQyp/PxaW8Dm3k1+nCJAjLsKA2rVHfGiAH
        qPjcFMozZN14jYvEHT3zkslOa9Vl4bbqo864Istb8xogQw7oEQ3uUXo1d4Gbkz8E
        v2WWabPqdGEbvD3+aEQihwA/tsrcI6+RygzFDfqNijRaNxmheEFtA2jZ79v+FABK
        XTZ1N5fruD42rbJGRPR9VZK+QjrjqmxobNAJMn8NZg==
X-ME-Sender: <xms:EZ_yYkQC6TZfbEPtpfUnMpZUKb86nm-FSxmbZVaFLo1g6JFu83nbEQ>
    <xme:EZ_yYhwr5Q8YpFUwvKjIi55gHUv4RU5gUnPyMlw8loIZkKQ1SoE0IDhDlcRzpJqVk
    qHMh843tesQS93Y_kY>
X-ME-Received: <xmr:EZ_yYh3bfqZHYFdrulTcXCddwc9FU6tqB9MqB_vDwmwJFA-vJEzJHpOzEViXmmfuHWtCnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeei
    teejheeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:EZ_yYoDFfkYeFxp5CdARqOIfmnupT4JvHd1T9V5PTOlc0QZTBoPo0A>
    <xmx:EZ_yYtjbrjcEVWRPckKgpIyvpqq3N0vIA3-53IlLkgPJ4Ejziqw1RQ>
    <xmx:EZ_yYkpH_krWhXfwYmUQ06sR3aXBb9DdoffW_ov06naPqGTVl9fBJA>
    <xmx:EZ_yYtfvqQ7SeBgleog9_Tau1vYnrf_HNd_QOM0f--lwTg5rQhDBdA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 13:53:21 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2A8AE103886; Tue,  9 Aug 2022 20:56:21 +0300 (+03)
Date:   Tue, 9 Aug 2022 20:56:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Message-ID: <20220809175621.qq4ksi6zzqpon7e6@box>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <20220809100408.rm6ofiewtty6rvcl@box>
 <43c610f9-8671-519c-108f-9996e219c249@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c610f9-8671-519c-108f-9996e219c249@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:58:18PM +0800, Aaron Lu wrote:
> Hi Kirill,
> 
> Thanks a lot for the feedback.
> 
> On 8/9/2022 6:04 PM, Kirill A. Shutemov wrote:
> > On Mon, Aug 08, 2022 at 10:56:45PM +0800, Aaron Lu wrote:
> >> This is an early RFC. While all reviews are welcome, reviewing this code
> >> now will be a waste of time for the x86 subsystem maintainers. I would,
> >> however, appreciate a preliminary review from the folks on the to and cc
> >> list. I'm posting it to the list in case anyone else is interested in
> >> seeing this early version.
> > 
> > Last time[1] I tried to merge pages back in direct mapping it lead to
> > substantial performance regression for some workloads. I cannot find the
> > report right now, but I remember it was something graphics related.
> >
> 
> Do you happen to remember the workload name? I can try running it.


No, sorry. As I said, I tried to find the report, but failed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
