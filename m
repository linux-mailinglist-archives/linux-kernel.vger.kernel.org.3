Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E65A94C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiIAKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiIAKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28612BF46;
        Thu,  1 Sep 2022 03:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8774261CD9;
        Thu,  1 Sep 2022 10:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A230C433D6;
        Thu,  1 Sep 2022 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662028690;
        bh=x2AYr6rJ/SXMUckmGysAK0XuQ4bB4VRnpC0UNZuoGPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqm4zjrTc7ZHzoXgBWXg4d4KPjgTtKiFHvVu/LkeNn7bhQLGQ7/LrMGtyB1fw6wXt
         4UQ7vhs13zd0lr0MO2nU0GdeYIhpJJk1r3n3FBsmZrye+DmQlY1W0/AjfNu3ZA3uxl
         W7vXbtFIKYWHVT2Rwxp+pwQqRHnndNqN/o6J00Sq4AsQcTXiDjrpl2m8zeZyuYfXkL
         77zzPuqeIJWfcZnVEnqnAGdrfnAGSde7p7snjJr3WC0rIu3Dm+RAILfIhndPsTjzlf
         riLTDTn19WdmOTTADOEgcH+e+H1b3yZR2oH+nqZUkYU8ikEEiPeu2cnbk1jjRF8ENa
         f6hUfN72qZbQA==
Date:   Thu, 1 Sep 2022 11:38:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH -next 0/4] spi: Introduce BPF based SPI mockup controller
Message-ID: <YxCLjlTZS7Ltahju@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <Yw5gSElhbYwoXrfw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GOEy7zVaOFT3jhOP"
Content-Disposition: inline
In-Reply-To: <Yw5gSElhbYwoXrfw@sirena.org.uk>
X-Cookie: Hangover, n.:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GOEy7zVaOFT3jhOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 30, 2022 at 08:09:16PM +0100, Mark Brown wrote:

> There was a series in the past year or so from someone
> implementing a similarish idea but rather than using BPF they
> provided a framework for writing device emulations in qemu with
> a simplified Python framework.  That seemed like a more obvious
> direction here.  They were initially focusing on I2C but it's a
> similar space.  Unfortunately I'm drawing a blank on who was
> working on it or the name of the framework so I can't give a
> useful reference here.  Their direction was towards having
> something that could also be used to validate what the driver was
> doing to the device from the device's perspective.  I do know it
> was written up on LWN.  Hopefully someone else will remember what
> I'm talking about from this vauge description.

The framework I was thinking of is called roadtest from Vincent
Whitchurch who I've copied in here.

--GOEy7zVaOFT3jhOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQi40ACgkQJNaLcl1U
h9CRLwf+MUzP7Y2coNWc2AokURZzxGOGnWydOKD2x36YEaANzDT0ZBInnbyB9xp0
j4sehqJXa9OJAGC73nT7iuFPukbLKwdg6AYXuEHTM7GmZCjaMWwVan/qHN7AnwD5
rJHKb4Qd/PjkyagZmGg0MHA8dRnhuBuALWmPj6wBa85IfB5p3U2/TqEu/ibDd6UY
SlgGNyTyHI5OUz/precQhRrAqsXcACVLQqTf4X7MdMxpJOtorepBBdaDk2ZDRnjz
r19oZKpRwkFW2eo6d57kTh1jq665PBw2L2c6EKx3GJQV+8rZ6xp87tyIFQNqkrFS
vseRTsv27aVuvPgDEV8HryurtqoiCw==
=umd6
-----END PGP SIGNATURE-----

--GOEy7zVaOFT3jhOP--
