Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8FE4D4D96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiCJPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCJPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:50:33 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EBE8B6E8;
        Thu, 10 Mar 2022 07:49:32 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so7188305ooa.10;
        Thu, 10 Mar 2022 07:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHZIUZH3BRu17R925p0XuXbUplbhpDdv8AbXFgVXggI=;
        b=CexjTul0LT3bAepwcLy0NmANxbQA9dhAw0AK/eyGjXEl4NYxFbe3WvolyYauKcgRnk
         FxHWWpdGccP+Ic0wJG1whIdObw5QPQuWO1j0lW1G7Yi4oZqPxD9DuAYYv5de3/OmBhNc
         wYByyDUH7MqIaO8KA4RacBgUVIS8Q0XT2GdNoXSHEooxx4FXcvY5/LTNn71fWeAknwWk
         3c87OZizYxza8vc4AT7dmlbw1EYMCioCXVcGYL9iUzXkdHMKzpPfNWAHK+cjCtQ43TUC
         9P3Ku0BZzVqyHvYIvD5yCF8kBBuj0AUSqBrs5unByIcegihhBZtGvGrAaoJO60R8fpr5
         c7yA==
X-Gm-Message-State: AOAM531O8TXKWOTGgNWamfRFll6wQxS/mVD/CefvdMhY0xgxXXcYl6NP
        JQmDp6P4e0wsJ0aR+OC48g==
X-Google-Smtp-Source: ABdhPJyhz88VEeUyiWQaRjVQVPpAgLa/HnD78tu1wnjOhoqPT3m0GH4PjRcoSYyS8dAoSg4VXCIWXw==
X-Received: by 2002:a05:6871:7a8:b0:c5:a1b3:43eb with SMTP id o40-20020a05687107a800b000c5a1b343ebmr3080692oap.103.1646927371449;
        Thu, 10 Mar 2022 07:49:31 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d2:449c:e413:94ed:2767:f2c4])
        by smtp.gmail.com with ESMTPSA id p8-20020acaf108000000b002da1bb5d279sm2506047oih.15.2022.03.10.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:49:30 -0800 (PST)
Received: (nullmailer pid 1694982 invoked by uid 1000);
        Thu, 10 Mar 2022 15:49:27 -0000
Date:   Thu, 10 Mar 2022 09:49:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
 dt-validate
Message-ID: <YioeB5UgtImMJsMQ@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-2-robh@kernel.org>
 <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
 <YiIa3Ox7UBLyBtoR@robh.at.kernel.org>
 <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
 <YiIio1dJd5mvMr0v@robh.at.kernel.org>
 <CAMuHMdXBkLbQVcNYhd=7z0RtU0CicsTF2BQLFRGBX6pNZZVadA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXBkLbQVcNYhd=7z0RtU0CicsTF2BQLFRGBX6pNZZVadA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:49:20PM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Fri, Mar 4, 2022 at 3:31 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Mar 04, 2022 at 03:05:13PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Mar 4, 2022 at 2:57 PM Rob Herring <robh@kernel.org> wrote:
> > > > On Fri, Mar 04, 2022 at 10:32:29AM +0100, Geert Uytterhoeven wrote:
> > > > > On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > In preparation for supporting validation of DTB files, the full
> > > > > > processed schema will always be needed in order to extract type
> > > > > > information from it. Therefore, the processed schema containing only
> > > > > > what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> > > > > > gained an option, -l or --limit, to specify which schema(s) to use for
> > > > > > validation.
> > > > > >
> > > > > > As the command line option is new, we the minimum dtschema version must be
> > > > > > updated.
> > > > > >
> > > > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> > > With this series applied, the various salvator-xs DTS files are now
> > > throwing up:
> > >
> > >     sata: size (19) error for type phandle
> > >     backlight: size (11) error for type phandle
> >
> > Those come from the code decoding the properties[1]. Unfortunately, I
> > haven't come up with a prettier way to report those with the filename. I
> > may just remove it because if decoding the property fails, we'll get
> > schema errors later on anyways.
> >
> > But I don't see any 'sata' properties in the DTS files and 'backlight'
> > is a node. Are you building with '-@'? I probably need to skip
> > __symbols__ nodes. The overlay side is handled because examples are
> > built as overlays (to allow unresolved phandles).
> 
> Yes I am. Dropping the "-@" fixes the issue.

FYI, now fixed in v2022.03.1.

Rob

