Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396A4E3E93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiCVMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiCVMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:36:15 -0400
X-Greylist: delayed 58886 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 05:34:47 PDT
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7D25C7F;
        Tue, 22 Mar 2022 05:34:47 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1647952485;
        bh=Whak20FtkcAMdSPUY5N3TGJkltQ6Kdru1OVmZtXLTjo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=3cF98St/QE1lUH/jBn46xk5zZYVdscNo00aoggZ39ZoMcSKLzuMnm5XcLh1SH7bBN
         01lklBKQbqGox6N8OJWEf7qI8ano0wOwbjSUBWgUTf82/vY0RVbu89dDad6JjEN3xR
         W1jFU4dOMheYLJ8Acn3iMtlPazNdwqcWOiDeR7+UT2Nu/7pHQ64rOyi9OBlYfaJuhn
         ux4jns+W7LrwmJz6NdaNcIkc+ed84yJd6/gzXSptcaOD3TrBfP7PEajJux71sm5KkJ
         +rVrsACrJ4wUfjXxiY0neD0CfjnfcXtxHo/lT8nrJ1HGA+WKRdu1/bY7TqtA4rTqhy
         6nstTpiMf8Iug==
To:     Daniel Beer <daniel.beer@tirotech.co.nz>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
Message-ID: <aCIXxTRSYEyLuh6AI7VpZ-BvTXmhEbOhg_A_O-sne9iOOHpX1-3pyQgGiIsifPSTbyX_P37DiL7XPQjzxYXV2VE-9U_rRYiOyKYIcg_ai4Q=@protonmail.com>
In-Reply-To: <6237f057.1c69fb81.1689.fec7@mx.google.com>
References: <6237f057.1c69fb81.1689.fec7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022. m=C3=A1rcius 21., h=C3=A9tf=C5=91 4:16 keltez=C3=A9ssel, Daniel Beer =
=C3=ADrta
> [...]
> +static const struct dmi_system_id fm07keys_dmi_table[] __initconst =3D {
> +=09{
> +=09=09/* FM07 and FM07P */
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Winmate Inc."),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "IP30"),
> +=09=09},
> +=09},
> +};

I forgot to mention it, but the sentinel entry is missing from the end.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
