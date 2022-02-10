Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88C4B0F68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiBJNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:54:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiBJNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:54:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC427C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C1CB8255B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD615C004E1;
        Thu, 10 Feb 2022 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644501296;
        bh=4T5GxSxlHHWGyyYwn7ZFv0DAVMPMJFjG9l8aHaQ2gB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7sbkJhHzVrU26hiKYcg+Ezd64u/+3cu4op9Bwj15hVpVamwFX5sYdvPTkjd8P2f6
         6liB3Qw3YkisZX7fIICk7joeUad9bkIX+fhLVMj4HRn5b/dwLC+lSPTrMh4VzvhxBV
         ZvyCXGqNIwahvMgFqEob7xR229BuYL8G0fqePNnBdNJDr3WC44KwFCKb/6HeLvZXsq
         BWFrSRpkdKShh3/FfXaKgA/WxvYTp8YPu6VJcYftZnMfKKCOq8/V8LikIT9nV6Tg7g
         c2Lwx0VZDn53tHlVcFm7MCx1GMY3mVR2wF83K8uvr4oua/vepMqyrnet6D7AjShkCf
         3uscYbY4zIbYA==
Date:   Thu, 10 Feb 2022 13:54:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        fred.oh@linux.intel.com
Subject: Re: [PATCH 9/9] ASoC: SOF: Convert the generic probe support to SOF
 client
Message-ID: <YgUZKgPacRNrFk/e@sirena.org.uk>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
 <20220210105519.19795-10-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QMm/tXeGvkQp+EWG"
Content-Disposition: inline
In-Reply-To: <20220210105519.19795-10-peter.ujfalusi@linux.intel.com>
X-Cookie: I want a WESSON OIL lease!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QMm/tXeGvkQp+EWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 10, 2022 at 12:55:19PM +0200, Peter Ujfalusi wrote:
> Add a new client driver for probes support and move
> all the probes-related code from the core to the
> client driver.

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/sof/compress.c: In function 'create_page_table':
/mnt/kernel/sound/soc/sof/compress.c:87:9: error: implicit declaration of function 'snd_sof_create_page_table'; did you mean 'create_page_table'? [-Werror=implicit-function-declaration]
   87 |  return snd_sof_create_page_table(component->dev, dmab,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
      |         create_page_table

--QMm/tXeGvkQp+EWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFGSoACgkQJNaLcl1U
h9CW0Qf/Q4GQ+DKEP1CNG0ioomd5kKN5fZu16CQ8wlQPl9Cp+h5flqb5dQnZNJGe
JuyktYDqCZxyJxGdzgHhBSnQ6lCtTW/b6KhBs08lij3PypAVXFyFIuEtbLM4N405
6mUuoGmoB7HcihCODnDZ+QAhbh7DtPkoN1SoOQO15N4EwYVkL4NuGFkJYD2Am57q
tr1V/YsYSYlyyuUemcfTQxOr8H5E0c3A7Zm8klJGhM7tIhDldAsoDZUKdh6l6747
PCe6LSvQ5EyTGj4YxAqYzLPghly8eXCgeRV1Xc4wnjBSn3zZmeal7/klX+p47HPj
8QMNhdXpErMJbT7SKZr7IPC3bzNOUw==
=nbVs
-----END PGP SIGNATURE-----

--QMm/tXeGvkQp+EWG--
