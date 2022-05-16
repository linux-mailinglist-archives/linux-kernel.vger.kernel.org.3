Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D4528531
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiEPNVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiEPNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:21:11 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 06:21:06 PDT
Received: from mail1.fsfe.org (mail1.fsfe.org [217.69.89.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A72655F;
        Mon, 16 May 2022 06:21:05 -0700 (PDT)
Date:   Mon, 16 May 2022 15:14:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsfe.org; s=2021100501;
        t=1652706874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHI3M8k0s+6SKuJM83gBORyGyL9zJEh7+p5BY+tErwI=;
        b=C9XGB87ee1pDrXxfeYbKRN/HK6T9qLGo7RtHWWuDZnHZlv3pvjm+ywpgVPI8bACZNep5Fh
        ICs5jvQRwNsKQvIiDWeISoY5882t9bwzyN+Vq7HuJ2zP/GuaK/dLYtu3ULJWjpBwQ9QITM
        b9VegXDSI9OO/pBRxVbgSVas5hQc+6A=
From:   Max Mehl <max.mehl@fsfe.org>
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
References: <20220516101901.475557433@linutronix.de>
In-Reply-To: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
User-Agent: astroid/0.13
Message-Id: <1652706350.kh41opdwg4.2220@fsfe.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for picking up the effort to add license (and perhaps also
copyright) info to all files in the Kernel. This, as you know, is also
working towards making the whole repo REUSE compliant [^1].

~ Thomas Gleixner [2022-05-16 12:27 +0200]:
> Finding files without SPDX identifiers is cumbersome with spdxcheck, thou=
gh
> it has all the information required.
>=20
> The exclude of files and directories is hardcoded in the script which mak=
es
> it hard to maintain and the information cannot be accessed by external to=
ols.

Unfortunately, excluding files (i.e. not adding machine-readable
license/copyright information to it) would also block reaching full
compliance with the REUSE best practices. Have you considered making
them available under GPL-2.0-only or a license similar to public domain
[^2]?

Regarding false-positives, e.g. in license-rules.rst, you could use the
brand-new feature that allows to ignore blocks of code (to be released
later this week) [^3]. I am aware that spdxcheck would not be able to
detect this, but using the REUSE helper tool [^4] could also be a
solution to scan for missing files.

Best,
Max


[^1]: https://reuse.software

[^2]: https://reuse.software/faq/#exclude-file

[^3]: https://github.com/fsfe/reuse-docs/pull/104/files

[^4]: https://github.com/fsfe/reuse-tool

--=20
Max Mehl - Programme Manager -- Free Software Foundation Europe
Contact and information: https://fsfe.org/about/mehl -- @mxmehl
The FSFE is a charity that empowers users to control technology
