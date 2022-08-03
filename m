Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7D588725
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiHCGKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiHCGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:10:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147861AF04;
        Tue,  2 Aug 2022 23:10:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5E1AE3200903;
        Wed,  3 Aug 2022 02:10:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 Aug 2022 02:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659507006; x=1659593406; bh=zbcXK+Pq3r
        2o6TfFjCadiK+q4efrY4aQSdlC3heWrjQ=; b=LbABIl7YmLmAUdN7XSujxI7fWI
        eo4hWD2OZYBKEsyN0Sbb8E8YlnE4tYpUOiJhgtjKJG5pAtHuoIK5E0s0cPNCUNtU
        6pVbmnF3mpVQOSMd/iuI+gFKBAwS1A5PCq5CJ+D/5f+CRoV/HTNe3atS41hYSbj6
        8BLyz6D5FALFRIyBJyexud2Ug6XSg8ARfX2B5GDrtlYoIukOIV5yGIlFNPmHqvdJ
        tiYAD/VSdV0SIr8ka06nxQFptzSTnolRs7AYNHqbNBFLOigfEl4qgLhUfP6WSM/G
        Cr7YBm0WKyABn/Y7r/MUL7wTeu16Pn0GleW0CloXWVH4xJrEZ2BWpCZuTzEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659507006; x=1659593406; bh=zbcXK+Pq3r2o6TfFjCadiK+q4efr
        Y4aQSdlC3heWrjQ=; b=p2eR64hzxzXCCMESuSSt58r6XMMgM/GVsBej//8+jDFc
        Co6M1MnJkDvvk7u1OxCjIgqPfXghu9FFyO7b2UhShv2t744S1IQovq7flzXh0SEa
        zRzqb4emypNcw0QZlY+7eZHeGRcLGy32DupuK50tXM4q247uaj8aoaUbrwuQmDE6
        7tlBvexiel7UuvWIkV0S1S+N77vYTnUuwEIk4JBzkkU35AGjbFdrU/3j4KI9aV7D
        qlfcrlWXP5G948i9jbqv2FRT0rafuQWnjedq2pNqa2PvgNQXesxtxI5atug86JsW
        hGZ6+3k7Vx2JYUCaFo8dtfECDQ6zfA8L/i+uwpPhJA==
X-ME-Sender: <xms:PhHqYrMzy90ol5kcGPFCL6ICcOOPN2o3nPFuyiq4uOHGZoPyhvm-Aw>
    <xme:PhHqYl_x8SrePusKqi3YnlbK6oEV0C6sdErIYMyDGQTVcwiwWj9WB8PmCblt130UW
    TiHquQRq_ojSw>
X-ME-Received: <xmr:PhHqYqR304SybrlzGGapbr-0Q74YRHeTi_-J5alq_yTZfhR1fbBuT9UrCSnKMI7E4z-bhwHXCpvlqhCASFkwbu5tw1nxyLwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:PhHqYvu0mlOLQiyq5Lq9Pcaa2KV-EEgEmOQsaSBFbctVCs5_kz-EZQ>
    <xmx:PhHqYjdVIFW2orkBaEmTsq3Txtkj0t0PFhIHXi_OTMphxarBVomflw>
    <xmx:PhHqYr1O7gws7dv1wheH-KKQzG0yqPI8ox8poqyhfxPAtAvO2PHnhg>
    <xmx:PhHqYh1kzOr3H3dw5AOB8uTHG6VezfY9xJFk_HnrnhWoCATHqXs0BQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 02:10:05 -0400 (EDT)
Date:   Wed, 3 Aug 2022 08:10:03 +0200
From:   Greg KH <greg@kroah.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <YuoRO0e4FM/vPn4w@kroah.com>
References: <20220802200649.2122084-1-broonie@kernel.org>
 <CAD=FV=X2aPq8Zsv-GSfj8Kz_9+MFxmejchoF4LUUY3tOLx3Ntw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X2aPq8Zsv-GSfj8Kz_9+MFxmejchoF4LUUY3tOLx3Ntw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 01:27:25PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Aug 2, 2022 at 1:07 PM <broonie@kernel.org> wrote:
> >
> > Caused by commit
> >
> >   c474c775716edd46a5 ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")
> >
> > I have used the tree from 20220727 instead.
> 
> Posted a fix: ("tty: serial: qcom-geni-serial: Fix %lu -> %u in print
> statements") [1]
> 
> [1] https://lore.kernel.org/r/20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid

Thanks, I'll pick it up now.

greg k-h
