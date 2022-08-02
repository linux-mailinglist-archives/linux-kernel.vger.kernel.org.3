Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D418587998
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiHBJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiHBJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:07:29 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841AF4B4B4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:07:27 -0700 (PDT)
Date:   Tue, 2 Aug 2022 11:07:21 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Update the maintainer PGP guide
Message-ID: <YujpSWaISTWm8/8w@ada.ifak-system.com>
Mail-Followup-To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Konstantin,

Am Thu, Jul 28, 2022 at 04:57:03PM -0400 schrieb Konstantin Ryabitsev:
> This series updates the guide to match terminology used in the upstream
> "protecting code integrity" guide [1] and brings the documentation in
> line with the latest developments in the GnuPG world:

I could not find [1]. Did you miss to add the footnote?

Greets
Alex

> - uses "Certify key" instead of "master key" terms to remove common
>   confusion that the "Certify key" is somehow able to restore lost
>   private subkeys
> - removes keyserver instructions because keyservers have largely gone
>   semi-extinct due to GDPR enforcement and just general neglect
> - adds a link to the kernel.org PGP keyring documentation
> - updates information about ECC curve support among the devices the
>   guide talks about (Yubikeys are able to use ED25519 curves with the
>   latest firmware updates)
> - adds a section on using PGP-signed patches with b4 and patatt
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> 
> ---
> Konstantin Ryabitsev (5):
>       maintainer-pgp-guide: use key terminology consistent with upstream
>       maintainer-pgp-guide: remove keyserver instructions
>       maintainer-pgp-guide: update ECC support information
>       maintainer-pgp-guide: add a section on PGP-signed patches
>       maintainer-pgp-guide: minor wording tweaks
> 
>  Documentation/process/maintainer-pgp-guide.rst | 287 ++++++++++++-------------
>  1 file changed, 142 insertions(+), 145 deletions(-)
> ---
> base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
> change-id: 20220727-docs-pgp-guide-1dfc91614c0f
> 
> Best regards,
> -- 
> Konstantin Ryabitsev <konstantin@linuxfoundation.org>
