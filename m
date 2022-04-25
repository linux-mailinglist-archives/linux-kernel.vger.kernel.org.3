Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC750E632
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiDYQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiDYQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:54:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939071A076
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:51:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dk23so7477003ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVn0XAxtnd65jKhU3aVzeHZPXVY5Iu5LmxmiFZBmeMI=;
        b=aKI2gT3D6RfE3L21yDbuQnslhT9dUbLhrVHcZP7oawLgG5j81UaG248Q9dmuQteVhi
         Nmp/ZQNjhRHl7QKim92lXxBkWlswi15VTDRxeSTeow+qi+zZpkERwOAVbU0jUZcFThK3
         G0kJ3rZ0mLigt7uhPDeNqd4Pn2mhcRpCc7eoIuXWbM46bVAPSG2uwQOR7rs1Ed8EXenO
         LgeZw8u3onJzTFWUvIftJy1mnJCwXIMQADG601BD2b3C4SxCTE+9213/FYyiXtAVBF8c
         qSbHbNhIqP/8k3+6RD9qmkM11TFF7l6tVnXSRGj9R0cH58yQyfSSToFTNZkXt3U/7uv9
         9G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVn0XAxtnd65jKhU3aVzeHZPXVY5Iu5LmxmiFZBmeMI=;
        b=r1nqMzTwPui4pI7sDQJrfrHETebr0eeDlOtFpR6zUIGXuFKo3u/JiERrTk/vWpw5jH
         L4coZS8LUkvrr+ET980dR33UfWJQ5cdhZ9gL6YJQbZ/RpPbA5c6M+84nYHsRrPOhz8KE
         5USEspHTonB1PhxQGAScrJKsXpTvXBtOjGESjf1c4Irn7raEZkNyxmuVih0offYJwtsO
         EA6T95fJgKT0p5WrRr/dmk7CPB/jWyDiTQ96Df54gTCAnfY7w4YDKDp+PvPzAf9ObhcI
         n5PY1J9uspfe4mRg4KtvzSdOZWP/xupyZXWBC9VsKrNIql+Q4AwAYrMphXUdnx/3cyfC
         RoWQ==
X-Gm-Message-State: AOAM530rkG0ctAT9zxjtIGQgm/DewOnj8hR50x39qAnMn1hlAmDGuChc
        6RV4gSqH3On5kqC7Lws4TZUoiPvmVS9UtcngfB/VAg==
X-Google-Smtp-Source: ABdhPJyHF71jfeEvAwRV1FJe/Thbe4byzZdnp82Szz7KRmgGYvZ1v6TJtXfdV3aBamYSdRHZnu9uQ/ouWh3ndlg5K6I=
X-Received: by 2002:a17:906:9b85:b0:6e0:5c22:f0df with SMTP id
 dd5-20020a1709069b8500b006e05c22f0dfmr17026932ejc.114.1650905509908; Mon, 25
 Apr 2022 09:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com> <Yl/l7gjRXj41a93q@lahna>
 <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
 <YmDy/xEsyktRS6D+@lahna> <MW3PR11MB46517BE51D4DCBC02B463C0EEDF99@MW3PR11MB4651.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB46517BE51D4DCBC02B463C0EEDF99@MW3PR11MB4651.namprd11.prod.outlook.com>
From:   Won Chung <wonchung@google.com>
Date:   Tue, 26 Apr 2022 01:51:32 +0900
Message-ID: <CAOvb9yhToxfT7cVzDX9cQhbRj0r2DXyuLJer64J8XSRJuUPcEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C connectors
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 2:12 PM Usyskin, Alexander
<alexander.usyskin@intel.com> wrote:
>
> > > > > Currently, USB port is linked to Type C connector, using the component
> > > > > framework, if they share the same _PLD fields from ACPI table. Type C
> > > > > port-mapper searches for devices with the same _PLD values, and
> > > > > aggregate them as components.
> > > > >
> > > > > When there is another device that share the same _PLD but does not
> > > > > registers a component, Type C connector (component master) would never
> > > > > be bound due to a component match entry device without a component
> > > > > registered. There exists some cases where USB4 port also shares the same
> > > > > _PLD with USB port and Type C connector, so we need to register a
> > > > > component for USB4 ports too, linking USB4 port with Type C connector.
> > > > > Otherwise, link between USB port and Type C connector would not
> > > > > work either.
> > > > >
> > > > > Due to the nature of the component framework, all registered components
> > > > > are shared by all component match despite the relevance. MEI subsystems
> > > > > also use the component framework to bind to i915 driver, which try to
> > > > > match components registered by USB ports and USB4 ports. This can be
> > > > > problematic since MEI assumes that there is a driver bound to the
> > > > > component device, while USB4 port does not bind to any drivers. MEI's
> > > > > component match callback functions should handle such case to avoid
> > NULL
> > > > > pointer dereference when USB4 port registers a component.
> > > > >
> > > > > In summary this patch series
> > > > > 1. Fixes MEI subsystem's component match callbacks to handle a
> > component
> > > > > device without any driver bound
> > > > > 2. Registers a component for USB4 ports to link them to Type C
> > > > > connectors, similar to USB ports.
> > > > >
> > > > > Heikki Krogerus (1):
> > > > >   thunderbolt: Link USB4 ports to their USB Type-C connectors
> > > > >
> > > > > Won Chung (1):
> > > > >   misc/mei: Add NULL check to component match callback functions
> > > >
> > > > The Thunderbolt patch looks good to me. Do you want me to take the both
> > > > patches through the Thunderbolt tree or they can go separately? I need
> > > > an ack from the mei maintainer it goes through my tree.
> > >
> > > Hi Mika,
> > >
> > > I would prefer the two patches to go to the same tree since it can
> > > cause a crash with only the second patch (tbt). Would that sound okay?
> >
> > Sounds good to me.
>
> Tomas is MEI maintainer and should ack MEI patch
>
> --
> Thanks,
> Sasha
>
>

Hi Tomas,

Can you take a look at this patch series and give an ack if it looks
okay to be merged into Mika's tree?
One of the patches adds NULL checks in MEI:
https://lore.kernel.org/all/20220418175932.1809770-2-wonchung@google.com/

Thank you,
Won
