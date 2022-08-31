Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000A5A8554
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiHaSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiHaSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:16:44 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA2E3432
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:13:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j17so11608418qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u1UVGt6PDJkRSWBfyxYzPJPgJUP53+mBBhKcycvTk2g=;
        b=DzjeZqnBEIOpRc0mqEBl5vCuzK/sA5YrAjEOSfzzRN+NHRw/jneFNPhOXOoa0/WAz8
         fapoH4MfjijFBac1DYoiBXKYAj6lbFwTnN5zLElx5Z71IBkIRItRnt+r6z/v1n0YsAwZ
         6BRIDW4+nXIcwSzg4MMBOBzBPVlsll5ktae+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u1UVGt6PDJkRSWBfyxYzPJPgJUP53+mBBhKcycvTk2g=;
        b=7IHeO1SaT2mapCn/fXyCsVUSOkuFtOlvbsscsO8W3+FY/bgL1kU4pI2/M6qHVtUP3Y
         BR2tN5GG7vAaX7Xr1na868kSTicWyCtWAI5hLryjCVG7bkYSYBqMAzaraLTcNco78YYW
         7CgiukZPrgCDq22lUN8PxS4sD0Sve5Dsgbo/8yNWcYoUl/7kj9yeKMLSJF2QZ750Tf2c
         DEnXC3OhJe1Q7ED+IMeA/+NlidH+T8Ua/CfCKG2Wpcms9ZvFxQMLBX7SYsYNft3EN+Qz
         3JhusoIMbYmU9ZSOS3IiqdpMoMsfSgOe9xtCuiAW+QOouliQQd2IuzBma1hcg4J2HMD2
         4pdQ==
X-Gm-Message-State: ACgBeo1cqmw7OTUkyC7yQgGZayE55T2WnqwrOw+qIXM0X/bPAwnX/Eja
        MwL5K8GlTCOcA9cO6Vv5f5kiFvSsuaZo8Sm83GA0670UyBA=
X-Google-Smtp-Source: AA6agR5OFUtG/N/PNwq8535QjQeYjw4uWLO1JLOAsKjXkpu6+BRuCFiHCNnvFotv4A2ReBXzk2skh2SdsmxB8iMwS0g=
X-Received: by 2002:ac8:5983:0:b0:344:5dcb:3b6b with SMTP id
 e3-20020ac85983000000b003445dcb3b6bmr20745469qte.503.1661969611308; Wed, 31
 Aug 2022 11:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830202018.1884851-1-pmalani@chromium.org> <Yw8frAv2pMfjmE0U@kuha.fi.intel.com>
In-Reply-To: <Yw8frAv2pMfjmE0U@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 31 Aug 2022 11:13:20 -0700
Message-ID: <CACeCKae_uB6O_=A6bPGq28zUivWhhyLpvb31c7gP5vMFBSetNg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Register partner PDOs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, Heikki.

On Wed, Aug 31, 2022 at 1:45 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Aug 30, 2022 at 08:20:18PM +0000, Prashant Malani wrote:
> > The ChromeOS EC exports partner source/sink cap PDOs (Power Data
> > Objects) to the application processor (AP). Use this information
> > to register USB PD (Power Delivery) capabilities with the
> > USB Type-C Power Delivery device class.
> >
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> This looks good to me. One nitpick below. With that fixed, FWIW:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Will you later register also the port PDOs?
Yes, that is the plan.

> >       if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> > @@ -1006,6 +1061,7 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
> >                                        "Failed SOP Disc event clear, port: %d\n", port_num);
> >               }
> >       }
> > +
> >  }
>
> I'm guessing that extra newline was just a typo.

Yeah ,I missed it during self-review :(
I'll fix it up while applying the patch if there is no other comment.
Otherwise I'll fix it in v2 (if there is one).
