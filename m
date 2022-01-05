Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3048526D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbiAEM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiAEM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:27:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA24C061761;
        Wed,  5 Jan 2022 04:27:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so3683891pjf.3;
        Wed, 05 Jan 2022 04:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46NaslxK0CBDuwzO8TgoSL/HvMffOQFuGj0G156NG9Y=;
        b=AuZGzoAweBdideoPYcdrbQkwx6fL2cTcKzJAX2gyfQjLYRP4dn8i02BYKdOb5vDvvH
         8jr02hE+gYyX11wKLfkYa5v24SpCdxIqt53VJJuOvoWIFDPnCyOSAKw0I+XmDh5iMUDM
         8k1JHhDC/kCynJSybsJZP2CJfmScBlFht/usEpADpuTcLNfs0rn5HJDvbaToQADcB/rd
         /M+xJX7+5/pbJk1AhMAL49nymj3Jw5O3Lsf1GrycseHFydb6NjW2PidXp6HkEiRFf/31
         cMyZpnurYYr+YRSqk3BZBwLix6K7t4oGnyom4R0jKlssCAIXGmmTAibArHOEf6eh5Uc1
         9DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46NaslxK0CBDuwzO8TgoSL/HvMffOQFuGj0G156NG9Y=;
        b=mhevZUGtchH67EtnmqjCAo25BLByvmpeQDw99rX5RF/HAWJKE4vf2j0+Q5i6gdgelv
         oTyTKmhPJBO6TGP+UHc3in9eI2rx9gnDDigksRpWqXOdd/hTIhOKLXBKVbY3OW7LZN1d
         V76bWLTxYWn3cuvBHtFJtWlCsaDzKhpSX1GA33MPZMNZoYDsrzxbmg0pPPt0Jzw2K/qr
         QddDXwZXGaRJ0cEtjB0BA+wS2ia7CTf3hRj0zEW4vT06erZJ1gc4IAnJS8TANee1yz+E
         e+pLX0ckJQrNQNwwefAxS33m+rW+JFSumcMrEil21Vk2yyjVSiBrB0jL8nHMNHqfkBrT
         mSIg==
X-Gm-Message-State: AOAM530UavrO92kxajmmE7+llGunh57eHIFk8okEiI7XVN6xh+8zciLl
        P12Mg4fcMdgkh8ttUqsq4sgnJZMRJEI=
X-Google-Smtp-Source: ABdhPJyC/OHGcK2uRp88D7Xgu7YxzGc7toAP+uUSoc/+MTPRoOPstE5p7tqoPOqBYflo6CGErcW+LA==
X-Received: by 2002:a17:90a:c210:: with SMTP id e16mr3836129pjt.90.1641385630830;
        Wed, 05 Jan 2022 04:27:10 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id k8sm49233784pfu.72.2022.01.05.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:27:09 -0800 (PST)
Date:   Wed, 5 Jan 2022 21:26:58 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Message-ID: <YdWOkn2Gtd7FSYmR@shinobu>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7aArQOflsA51RSk6"
Content-Disposition: inline
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7aArQOflsA51RSk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>  - I think intel-qep.c makes the counter unfunctional in
>    intel_qep_remove before the counter is unregistered.

Hello Uwe,

Would you elaborate some more on this? I think intel_qep_remove() is
only called after the counter is unregistered because the struct
counter_device parent is set to &pci->dev in intel_qep_probe(). Am I
misunderstanding the removal path?

Thanks,

William Breathitt Gray

--7aArQOflsA51RSk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHVjocACgkQhvpINdm7
VJLp1Q//ev76+YaOvx1nSrhlqo7QTyCV0pU6DFUBoZu0imahFYInkRiud0z7X/v/
cc7aNEEbYnb0zJEMDGwgDXthBwkwCoWuLPC90j5b3BqcDE1DcEnDaASIgs2PDpSE
9bLRfFbJDNqrRzL4rmxyehbbgfjI/o4SH+bp7JzuOck5xAgleCKx1X/KbXW91eec
BBAZEpy6MH2IM6AX+bPA5pIh75wu1PQt/wLwXMk/ZIK8ATqNxIqlmlzAz8SPnqhj
6KxXIRZMHHVHcLT3THC6Sn++HHE0UPokF88Zxk5H/QA4aks2RbklzHsxLGsOD/k7
dCIFqB2Ll3bM4goqKPySVLJMXQmj+nwZENZyy8hpiaMn+ZNjrtkjEPskiUfqwBSe
DS5xmmHujd1+MEVhSJzqbNFcbR6fnH7BWv8UZNEApA0F1GTLgtWpW4ASMrxm4fsq
XmOFrjrXNPBtpOGDGAjh2kb/nFQGLKOTi75JhUw5yZKCljNiRUFzfhuiMSUSZLbp
Rt6tuXe46e5oB8IzHwG9AhcUvwhHlbWPvTWLm+4KeS+5Rxqk6DbVk2sKStJiLTgT
+reCFi7agu3bEisb+3wA0aEbasqNxozZUWGFmZ1po06G36OD143ZI/FGMf5NUhkZ
FyOMu441A9SD0Pi5IaXCr5a/L7zOT2ChT9cUKs1Fkx6tyIsXzwc=
=3xlF
-----END PGP SIGNATURE-----

--7aArQOflsA51RSk6--
