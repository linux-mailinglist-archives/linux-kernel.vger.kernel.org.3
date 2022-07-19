Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE757A60A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiGSSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiGSSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:04:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB2C52E40;
        Tue, 19 Jul 2022 11:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF29B81CBF;
        Tue, 19 Jul 2022 18:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E51C341C6;
        Tue, 19 Jul 2022 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253869;
        bh=5OfFErLFBejt60+IIJPAQA9g/7Onr9MuvpCgu+Z3+Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo1QbMqhFjL82JpmX7pQ0sog/PjleOuEoUbfX4PM9/50KjxF2YgabgoT7W9iczHAj
         oH2ii7Xd78yI+YwtYyBOGD1bcFXNifHCBZHQNe5RvxGJYEGr26NB374fGF+JXBaM4k
         k+H8xSSfOAS9LpukoIkrU4PYUTJtA/IHp5eP4GRTG77mfzVZ44LkQHH3TfYWlfXyoQ
         67pGwJFBfAgHixRfkVf0f5GSKp6liO0kVwVQRNbcDiWK/saCCKSWOSu7Ytp1rpT82c
         YxqAqWoo3NZoGRLv9aQVDZ9obo16Ncv7StgncII+8C7QN/xtRBi069i/XxZyGwr/BB
         588yAdTGX3DHw==
Date:   Tue, 19 Jul 2022 11:04:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: build failure of next-20220719 due to 'missing MODULE_LICENSE()
 in lib/crypto/libsha1.o'
Message-ID: <YtbyK2/jLGqcp3Rc@sol.localdomain>
References: <YtbBb3gCsKfpsaXP@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbBb3gCsKfpsaXP@debian>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:36:31PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Not sure if it has been reported, builds of arm milbeaut_m10v_defconfig
> have failed to build next-20220719 with the error:
> 
> ERROR: modpost: missing MODULE_LICENSE() in lib/crypto/libsha1.o
> 
> caused by ec8f7f4821d5 ("crypto: lib - make the sha1 library optional").
> 

I already sent out a fix for this:
https://lore.kernel.org/linux-crypto/20220719030415.32113-1-ebiggers@kernel.org/

- Eric
