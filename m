Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA645752CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiGNQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiGNQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:30:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5F655A1;
        Thu, 14 Jul 2022 09:30:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o18so2019420pgu.9;
        Thu, 14 Jul 2022 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KMvgUo5DFbdUy4r+dfQ8/l8alJs97+14aru3ICZ5dWE=;
        b=aVYXqeHR4lLS66BV84dEqs2N7IPHrywmQzWK5PaawnJ3IDE1pQ9zAEolcs1RKiOIio
         xi1h0gC/7rEbWpuhBa+Du1vRxZr+v6qznl3fuBnTlNrwmaWXRc8qzZgwH6Cwln2PcGAV
         NwuOeCG59C8a7ytUrJGNdVIvuOhKHgOk9jr+N9W+bHtf9+bPij1Pp0+6CJFDOLCVq9nE
         Bych74VoDEPqhMPVRTXswi9XLBKFAgYQ2/5d6e3LRW4kVFOgAEHKiHnX9nYb8pqC+lbL
         9vbg57Zy8bNW/pSYeO3OQX4RuVtJoBaJoDfd5+YM8hL6812Z+SNCD5jzL6QtleLaiR2S
         LQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KMvgUo5DFbdUy4r+dfQ8/l8alJs97+14aru3ICZ5dWE=;
        b=qEAwnT0j2EWSASkgZUA5XYoIIfO7NYov4gcLGdZODQx6IVyvZ7yxvdeMiEAk2h/XGd
         ze57Q5+31hgCsG4xD5CZZMVRtgbazFrSgHkoTlG9pI7HBp7Sno7K7Tms9Gasta9LSmRh
         L0LHlppjnsaUPLJcFAFjTcIoWdJpfnCqdy34PYyjm06QSgB/l5dVRAqsScjg6CjUUqMy
         peHlhKl9NL8AndiHWQTEjPgNFbuAPFJG2I432C0o+7KxC9eIz3RwIk0/DY1dh5Qzpb4S
         hXhM9rE7FJvB2RMe8waHA7nTlY8/4SniSIxT1Brq00hPAJh3vHECCEYe7Q4+oObQ7phx
         BISg==
X-Gm-Message-State: AJIora9eGO717fHv9b5yz8eHZ74AELAa3UO3VeIuOXkhK92fyOmoNcn9
        SXLDQsCE449AU8FD5g37RIPX3ceUAs/qPAJ50xQ=
X-Google-Smtp-Source: AGRyM1tS14qGXtCk9KbXJ6e3xehx84e35ntlJxOWVAsxIo439cdGoV34KvROhmpGBYH7yxy26wQ3KIwtpMSvZXhUA7o=
X-Received: by 2002:a63:4847:0:b0:419:c8f4:4f88 with SMTP id
 x7-20020a634847000000b00419c8f44f88mr1552857pgk.603.1657816248636; Thu, 14
 Jul 2022 09:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 14 Jul 2022 13:30:36 -0300
Message-ID: <CAOMZO5BNc35_v5c4oYbO4DpGAv4shzq63M1eo04V5NJ7na7FSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Bind the backlight controller to
 the LCD panel
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:25 PM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> Add connection between the backlight controller and LCD panel.
> With that the backlight is automatically switched on when the panel
> is on or switched off when the panel is blanked.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
