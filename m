Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF74A6B01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiBBEmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:42:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38423 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232239AbiBBEml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:42:41 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D1C185C0184;
        Tue,  1 Feb 2022 23:42:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Feb 2022 23:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=9Fu1L53JHD2BEq
        uVl2Vb9y1iwWCLUhaDxYdzJpr+2wE=; b=BDVSa4hqtdY7r/REsB0e0BXP8Hasa6
        CbaqI+zUOXhJu05PbU0qhSifaba0XAfh5BJ57upqgxkH9fv5KdnZH/ogZB9DQTFr
        wALf6OIjsl+LRi6HLrCNBg+BNN7whGyT84FqcXdNEhMAam0grHWjyWUAmXP59nwU
        Le3QNF7AhiMsYjiqveZGNK/E9e2P+RoqQErRJzL+FeoyOkabxXwsunfIQ5p7gT8q
        8/x5217dGqiAP7FLKE+xdfOySoQzq+bd328eyE3xNq8ga0hANxfihNrdKshu6O/4
        4Wd3J3JpkDjeOZQb4yTSG0fLRPK/TrUZFsdOZnKZTV15kJbx1K8yQ81g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9Fu1L53JHD2BEquVl2Vb9y1iwWCLUhaDxYdzJpr+2
        wE=; b=l7KNIHbrNbXzv+IWa2surYD6hdI0IJKWRHWB9fWYNUA1idZSiCTnE5MFR
        0BWPpRp8VhcXtFH11dQql2RPXx9xITjfXLMjWqcqkYV4kV3AWVcbYLzVW/iqEQNF
        qU4JRe/IJEYw8eBCMjzA7XIsv5u/g8iNBg7fMqouVOZLwGURBm1meJ/ttjh+H41U
        y1EA0f+Kk58PEW0Pi6x9yzQF+/9Fqyb6cV+Zqnuj7j0/+myzefH3pZS+R7qzw74f
        4JssGBJjdGiaUzfZeHI47iJTMv4fGQtm+U/tk8XJ6xf6aBpct6goEzLpu+516NTk
        K/iDlqAbUGEdCi6xTn5fODtMk5vaQ==
X-ME-Sender: <xms:wAv6YfmkX_C2NBCj6HdyDD3Ir4MQw1mdmqDUv3HQokxCNSy1q8xV2w>
    <xme:wAv6YS0Qc5KbUUKVCUTzC7NIeBXlm7qF44ZSZ16WpxARR6acqhU4My_VACCiIzT3_
    U62SwQ0mlQnUy77fA>
X-ME-Received: <xmr:wAv6YVqpYqI1lWztmNXamkecB0CZBhWO3PQy-P6fDl97hm-PsorqhoIYBJkNiL5KEpHumDqtiChlMuxpVPpkwQDxuSxKkWYxBo8taemFARPSEs0vY1U_I3G3UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeetteffjeefhfegtdduledutdegudffleduueeftddvlefgieffveef
    hfdukeegvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:wAv6YXljBDhCAtteqD95c67VcXf6h8e1iK3JzYX1RgjG4RbRu7lbaw>
    <xmx:wAv6Yd3UDKk7klR5igU7bXlI87p5Ek9zdki3rOfBUmEjekRykVdG6A>
    <xmx:wAv6YWvMV-Rybu2E3cwjLvkIwEDgyKAHm3NGLfs0_QOGOv0BmOCiOQ>
    <xmx:wAv6Yan_JDwM8TA2yRtJOg34nYyInzX53zBXGbZtKKgv0kYGOE8ixQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Feb 2022 23:42:39 -0500 (EST)
Subject: Re: [PATCH V7 2/2] irqchip/sifive-plic: Fixup thead,c900-plic DT
 parse missing
To:     guoren@kernel.org
Cc:     anup@brainfault.org, maz@kernel.org, tglx@linutronix.de,
        palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220130135634.1213301-1-guoren@kernel.org>
 <20220130135634.1213301-3-guoren@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <5b59a816-a1a2-1e75-9c78-8bc9be18f70d@sholland.org>
Date:   Tue, 1 Feb 2022 22:42:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220130135634.1213301-3-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/22 7:56 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The thead,c900-plic has been used in opensbi to distinguish
> PLIC [1]. Although PLICs have the same behaviors in Linux,
> they are different hardware with some custom initializing in
> firmware(opensbi).
> 
> Qute opensbi patch commit-msg by Samuel:
> 
>   The T-HEAD PLIC implementation requires setting a delegation bit
>   to allow access from S-mode. Now that the T-HEAD PLIC has its own
>   compatible string, set this bit automatically from the PLIC driver,
>   instead of reaching into the PLIC's MMIO space from another driver.
> 
> [1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Samuel Holland <samuel@sholland.org>
