Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45F5785AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiGROmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGROmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A531CB1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87520B81624
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165E4C341C0;
        Mon, 18 Jul 2022 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658155332;
        bh=UlXKGw3wswQBoe55GKmK3EWF72k/vU71U/xFeMphZgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTuVfAV74JUprgeH0PFj2L21uzPOACP9YLcVkeeg063FOHAHGGj2chNPzZV57zX3h
         Aiv+Shi5sNms+ifiElnPMSpCBn5K5OuUD6eb1FHubIkVcNzbC31WEHUVVLEZCNJnk7
         s3PdkV7X/Us4NtyDN2niK7WhsSvH3PMLhfSZhaCciAPbz/KrMMej7cu1VA37z8Fyp3
         viLx+6icPFLs7//Cq+BCySpZpWnGlw5Y3RdQVvOXyaWUltbAcm07erXBzXQf046cqT
         7mQKOv/7G44bI0Zim0oyq45plnkX7q7Bfky2J222zoMwlOLQhnXG8OrSMZTn0P/Ufj
         pGKbqG/Advojw==
Date:   Mon, 18 Jul 2022 15:42:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] regmap: permit to set reg_update_bits with bulk
 implementation
Message-ID: <YtVxPjzG2JrbPTKf@sirena.org.uk>
References: <20220715201032.19507-1-ansuelsmth@gmail.com>
 <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
 <62d564c7.1c69fb81.9010e.da70@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QwD6vKWDoJl6GzdT"
Content-Disposition: inline
In-Reply-To: <62d564c7.1c69fb81.9010e.da70@mx.google.com>
X-Cookie: The greatest remedy for anger is delay.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QwD6vKWDoJl6GzdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 18, 2022 at 03:48:52PM +0200, Christian Marangi wrote:

> thanks, assuming everything went smooth with the merge to linux-next and
> no problems arise, can you provide a signed tag?

> This is needed for a net-next series that is currently in RFC state as
> it does depends on this.

> (I had this problem before and it was said that in this kind of
> situation I had to ask for a signed tag to merge the related patch in
> net-next branch)

Oh, it would have been good to know about this when reviewing the patch
rather than after the fact - since this hadn't been mentioned it's now
applied on the main development branch with everything that's going into
the next release rather than on a separate branch for easy merging
elsewhere.  How urgent is this, given that the merge window is likely to
open at the weekend so this'll get sent to Linus at that point - is the
driver otherwise near merging?

--QwD6vKWDoJl6GzdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLVcT4ACgkQJNaLcl1U
h9DCjgf/S/XTEX6c7UN9OtZ1eD3x5g7lGVLn92WFnPxTt2oQwJ7L9fMWSJOe1ecd
Wefnnf12KUBpyaQUT/YS9ic0ZUkMZgdfPTSg8PKvgX1E7w0rAd+RCOh68VUocpDB
xgfXhhifl5cEPEjiLWR/3W9zu6fspGGKLC4wIjGfk9Sj2mueB+LlPIP87lKq/etH
lfryx+YLJQZeizCUGYP+gC2rZJ73NR4H4A1VuftNEIN8uLhndTA9e3aSXthe3q9S
OIoGvDBiFmL4fe6zpRi9YGKvE/dIj3xRxv+SwCAOPAIqUlF6BjsJFW2/eqtY3XTg
NSF07KtuVyxxYv1XYaDQ7Jb/rUaudw==
=59px
-----END PGP SIGNATURE-----

--QwD6vKWDoJl6GzdT--
