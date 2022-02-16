Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA94B8EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiBPRRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:17:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiBPRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:17:51 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFEBECE5;
        Wed, 16 Feb 2022 09:17:37 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4EF473200953;
        Wed, 16 Feb 2022 12:17:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Feb 2022 12:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=oNwOSQ3qh0rFRs
        kCwE18LbAyBomZpSW2k/cB0L6ZHJs=; b=NOU0wvUk7VoHj5PaFSko4qNGTm3uMO
        KkrseP68AbFPwl3hv5mR3TeSgd64qS5uSVhAE7YwFcRVIObTa7wDJ/hv9NYMFl2Y
        xyViqXdDUq9H2JCWeuPnHAzTQu1NXm3+rAH33BT5xY535yRXCwsBRaBZ6Ih4S/GH
        F+OYmQgmvlQ2AmtWKnz2RpblExvLktwkPeLeoQLTrbfcYtfKiHFZmNnpHs2o7ht6
        i5wxPlarNIwABym4XOQPnm1uzDVG1phWLDi5WNPrgi3FIoiti88RWNnD3buf/ZnA
        7iJRWpnXPjdyADOuTTbaRbrUUetiAPleUtFR2Ic7exledMrJyNz83xkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=oNwOSQ3qh0rFRskCwE18LbAyBomZpSW2k/cB0L6ZH
        Js=; b=ctDVde6Cwf0HU65uLPJjAxX+sXZBkz/DXdTyz65f3WOPdPe7tFckvxK7X
        RJfNeJLCQOFkm/UkVq4yzMtzkuYqRSEttGmB2DagENcGykstCXIjQ103KPaOXBtP
        dQ3bOr9PtG+XA/nn8HUTwVLCzjb6xeGrDv75uaoXHYvCp80k/zxKtfn+PYNsAwXo
        VQh4cXmjVbxKBIp/LO0NYwEBaJ38ug49v4OfDChC3wKV/JX+ujkomJWD8We+BbDy
        McAlBcYV3cpHIU3XDMkocDeOsx3m6GVKkFd53PaNrwPkabndaq9erbxxq5l89Wsk
        lmowWEufcpoRn1yBnRkAnwQyoQnug==
X-ME-Sender: <xms:rDENYlDyT9vfJQY8EOD_7yWM0xZYEFQrUe0FdKNctMUR8Oebgk8kFQ>
    <xme:rDENYjgodD57Sux7cagIGg9uuPEBwlslPErhh6uoEn3jZP8cmmP1Zhhg8ht_40ZiO
    P9EaI24Pk_ks-Ky-ko>
X-ME-Received: <xmr:rDENYgnIl47-JMGupNvqIvOvJTW4NWnfwENQ49RQqJ4fssc29B02m7Ka8nDod9mjm1SujN1KoQ0hbFTJtPwT1sKQuM4e1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepudfgvdejvedtieeuteffkefgvdef
    geeiheetieeltddvveefhefhgefgudektefhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:rDENYvyth4-aOVdU-HNSfC_jchLjBikk72ieiKL--3FtACL7CHm8oA>
    <xmx:rDENYqRAqSu5tvsqIr9rVxze1p-2CbmXxVs3SxISlKnePBrQvLgJsg>
    <xmx:rDENYiZ6OvcCiLma39nAfAZbS2YSvx5bAOG8luDh0NZXLErn4OJ2EA>
    <xmx:rTENYpGL3sa8I5gV1Jh5cxACk-K57y7un5WX4G7383oBRxqacyxDIQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 12:17:31 -0500 (EST)
Date:   Wed, 16 Feb 2022 11:17:29 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Potin Lai <potin.lai@quantatw.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] update Facebook Bletchley BMC
Message-ID: <Yg0xqSV+k/O+vwSs@patrickw3-mbp>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
 <CACPK8Xfs34gw2_XGeduJ6D=-khN7RtMj3LY8hQ8B96fFxMuE8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACPK8Xfs34gw2_XGeduJ6D=-khN7RtMj3LY8hQ8B96fFxMuE8A@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 05:01:56AM +0000, Joel Stanley wrote:
> On Tue, 15 Feb 2022 at 16:32, Potin Lai <potin.lai@quantatw.com> wrote:
> and given the minor differences from v2, lets add Patrick's review:
>=20
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
>=20
> I've applied these for submission in the v5.18 merge window, and to
> the openbmc tree.

Thank you Joel.  Yes, I concur.

--=20
Patrick Williams
