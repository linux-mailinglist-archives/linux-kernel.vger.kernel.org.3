Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545CE55D695
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiF0NlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiF0Nkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:40:46 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79065F44;
        Mon, 27 Jun 2022 06:40:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B7F9E5C00A0;
        Mon, 27 Jun 2022 09:40:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Jun 2022 09:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656337233; x=
        1656423633; bh=VmH1ItcgdR9yLmtHIQblCwoWnqaK8QpzOYYSIYStQo8=; b=W
        6ZgPzFSOSstzSlPkL96ySA528auJvAslWW8vDg5qezyJvV1+N9u6zuEuvAM+oaz+
        ff2uSB//o7HZ1x7GS89mc6rF6Lkt6CpWLeykpnkB5Gg+MRmML1s6ug7ngz0huLCp
        +15HPU6L/ZO5Lm4csRgW1UCzn6Wq7OyZFvDH/bHsmmH/GBuPIFn1Jdbc9Tz3dYsf
        ilWgpvZimbSueJQ0wkpFMGwlBYdxuUkN6E/KB9KOWLtNSQT4DYRvdTzDHYsGzdA+
        v5NJRLgwl9cPGCjryDawOjET0KV3KlA5J532XRMZpt8tB40wLY/XsOYxdkf6USe9
        Emo6VoOLgbZj1874ASqfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656337233; x=
        1656423633; bh=VmH1ItcgdR9yLmtHIQblCwoWnqaK8QpzOYYSIYStQo8=; b=J
        l4m2ts68BiSTJYOGXO4PS2bCXxr52bv3awRlpRjZkVMApRevrN1swf91dK5VSzbi
        vlDgC0174yQYu43xulPkY+aNZQ6yxecj/iRNlDm890XFGqRt87oTeOgFBMLrEdu8
        N0iglfp90QEV5tuBoGtbZV5QEJjySJLN4Ukd7SHWXtI85+YVsnlA5sptVyFcmsHo
        qD2JQdBScvSqrLlINFzjSqivKRYMytay9NLIozOzhmWvfB/NZ9LRLDCErDT7VrQv
        wOp7ar1nUioXyXUzLJo8N5ZuPNx3yE4Q8BaUnijzTMTJhR56vPlSSDINd6ZK3pHr
        o1yJ7E35bBgs0W8xhXdpQ==
X-ME-Sender: <xms:ULO5YqQdhAP1iaqPyXjKmIfe46gbojhZoh7V4WqFnAoTAZMsMcnwVg>
    <xme:ULO5YvwSCAXTiPZ0KOt0vTIwi1H2VF0NlI_zfOEoRSool3pmVgvyjL1q2XE5Wr7Ap
    kjEkUry38moW9tWiw>
X-ME-Received: <xmr:ULO5Yn3VLmXUeIRtIPSjjHtpzyDPH4S1Avt4qY0nA9yA1jTM37eLEA-n80lthjT_jK91vEsdPtS_QlqvmT8R6vMv8U-boIjBwhuyAbdSFYHwSr4dvPreA68Chw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ULO5YmCg3qKg3H2zkHxC8ggOnMAeXIu8t_lLi-c-SDYgpuvetJEgDw>
    <xmx:ULO5YjhNpLHQNaLdXvKbXTN9bKfBNphIqrkKUcWqVGCgU60n4KhOkg>
    <xmx:ULO5YirN24BuX9prBn5c0WfcVXsLwrOc2hXNdAzMG_oiY6o7XXBD9g>
    <xmx:UbO5Yjyvm8HKhtO7p0wx_qWAmKqei6H_ClCvwYMPvfxjirzctg0fvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 09:40:31 -0400 (EDT)
Subject: Re: [PATCH v1 2/3] irqchip/sifive-plic: Name the chip more
 generically
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220627051257.38543-1-samuel@sholland.org>
 <20220627051257.38543-3-samuel@sholland.org>
 <20511a05f39408c8ffbcc98923c4abd2@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b031cfb7-6a50-cc01-3b8c-5e75d01b4a43@sholland.org>
Date:   Mon, 27 Jun 2022 08:40:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20511a05f39408c8ffbcc98923c4abd2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 2:11 AM, Marc Zyngier wrote:
> On 2022-06-27 06:12, Samuel Holland wrote:
>> The interface for SiFive's PLIC was adopted and clarified by RISC-V as
>> the standard PLIC interface. Now that several PLIC implementations by
>> different vendors share this same interface, it is somewhat misleading
>> to report "SiFive PLIC" to userspace, when no SiFive hardware may be
>> present. This is especially the case when some implementations are
>> subtly incompatible with the binding and behavior of the SiFive PLIC,
>> yet are similar enough to share a driver.
> 
> Too late. This is ABI, and not changing, exactly because userspace
> sees it.

That makes sense. I will drop this patch.

Regards,
Samuel
