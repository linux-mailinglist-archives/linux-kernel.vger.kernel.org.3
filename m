Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA75510D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiFTHBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiFTHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:01:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8416639F;
        Mon, 20 Jun 2022 00:01:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 62E615C013E;
        Mon, 20 Jun 2022 03:00:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Jun 2022 03:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655708458; x=1655794858; bh=I5UTZA/DlJ
        LiGMyyIN/ZRv2oZQmKZ75eHmVu9YijFU4=; b=tsuYN0w318YQ8sJbzO3pqGbZ1n
        RsD6+5/QZ3kUN6jU19ttBG3wgBW9lWxdL5Sghngrws/Es9sizrLsJERPfxHy8ErF
        LtTGw5X6G+XlU2wn9CBoBIxShiYFaxYSWSx3PWHSNRVE9SXSJuFHAfYhYnGzk2iu
        1QrCX+DwfqKfhIeKZuBc9wrpRaGhvX4NOLMiG1GgaB8KNHqGTnFa7oEnjcWXkgyv
        rhPrpLGezvp7GSlq8KVgyJcEaqzlJ+vji3mMxEUrjV9D8eRqZaqLqwmt+DHQilP6
        utBe3l3O+6ZbmGHwnvtMGo4+9p0US0dxIVADZmYstrAJ9jaO4Q96OUqCVeMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655708458; x=1655794858; bh=I5UTZA/DlJLiGMyyIN/ZRv2oZQmK
        Z75eHmVu9YijFU4=; b=Ew4gF2rYjhm7sUdzY6aXz7sMKVZo9Poxxx4y4rE0J7q2
        hQCY9f30qKvC2a9HwECA9Px6/Av74R78FL/ZTUOqvYhVZqiQRb6GRCdQqICkzHlg
        +2qE2sh9VfEg0ruLN9+r2wJ4hClNbhkt5QeSa+rE/DWHiZzt0DLe15b46RTZ7FGu
        OyHGUAAsqnOEb74CjVlkIV9+ZSAKKeLql7fv7mzRIfPEs140d9BtfSZyEknRVLvf
        MXu9VcrLEnjGAnOMwEOWjK1aJf47+aMEYpaZaxXNAtzjnlCrhbXkZrnemwplq+r+
        G2ojk5mDalnCi1Ckn8s1h/JlKE9nOCMQqeyIouUG/w==
X-ME-Sender: <xms:KRuwYrrHUiYk3gWcrMhRQ60U5yAYlr98THNti06QGZB986txAcjYFQ>
    <xme:KRuwYlpCHmSgSkKHs0t3JScB-pF1yRVFwTu3L2DlpSeaK1wHBPKtpiFSr_1kGklGh
    eNykceQJCE3Zg>
X-ME-Received: <xmr:KRuwYoN01_7HZmZOHyJ5VWA6UHLUIB6pKBwORboTWfPcJ3IaHYVGXogGqxXyA816cFLEXsuiL3XmmgGJbP9VcuzVBJ9S1j44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeftddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:KRuwYu65EVw7GC1DL5BE-nmlIp6oK784NnyJnN8c9uwJn7lpP27Q4w>
    <xmx:KRuwYq7CQyirvPqumgeoewuuC3_U8S1Th2um2iheC3hc9Oo_0HoREQ>
    <xmx:KRuwYmjUEOOL1t6DQ9EP4kRh8ZtYKEWKyeMXbYJKynlgZYNk26JX8Q>
    <xmx:KhuwYsuDqIYjDu_dpLv9Xuk-zKV_cGJDwNot45qjIEtEMhHQbqODrA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 03:00:57 -0400 (EDT)
Date:   Mon, 20 Jun 2022 09:00:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nam Cao <namcaov@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <YrAbJUaGKged6i8C@kroah.com>
References: <20220614122448.1360395f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614122448.1360395f@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:24:48PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c
> 
> between commit:
> 
>   96f0a54e8e65 ("staging: r8188eu: Fix warning of array overflow in ioctl_linux.c")
> 
> from the staging.current tree and commit:
> 
>   ac663ae22f02 ("staging: r8188eu: replace FIELD_OFFSET with offsetof")
> 
> from the staging tree.
> 
> I fixed it up (I just used the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Should now be resolved, thanks.

greg k-h
