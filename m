Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E25750B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiGNOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiGNOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E09562C3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B07B0B82627
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389C9C341C6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657808632;
        bh=ondxzTzSHvYAUKgrQuksilEhYfYB+ZIu538a4pRtHvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PaaO6DebD9CQOaQP29w59lExhiAcq4J4UAFDmFEBHhsg5J1yNaiBTdac13qXhTBWY
         46oqgJxief2Eqirp9rAL56cBr9osvp1A+FKcOY/c9RXlG6A3E/NXcSup7TUXaExOum
         Xor/jAHfI0T5KyFtVAJwhtyjBygF9CPIp3EG0PLc/Fbbz5y0G/F0iYMIUhRtq5DhWf
         vB42tra3nCSYJaAtqcXontVhCrgKrB/RqkG2i4c6MflRX12ZlqMHcQUvVqJtBOqX4q
         mP/A3Quu4cVQCnNMpq90jtVs0VbmePgrZbJcJg1cI7eXzysR72Y4a+1GgocbHukG78
         aVNPLygPkPKCQ==
Received: by mail-vs1-f53.google.com with SMTP id s1so1571925vsr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:23:52 -0700 (PDT)
X-Gm-Message-State: AJIora/ss41ESlZO3MKBSiAsujZbKoBrcpYRRYdBi+K6vJaVcMz4Pfh8
        sTqyzBaIl731B9ipL+BTVeh1zrsEjWamVGfzpA==
X-Google-Smtp-Source: AGRyM1uDEwdv+KF5pevijLlHPYzYRVqfG22KbUB9jLgKGtjGyoooXllMwfupTBOjfQWdGLDUVm+Pv2iG+7MQ34spZnI=
X-Received: by 2002:a67:c18e:0:b0:357:5fc3:45d7 with SMTP id
 h14-20020a67c18e000000b003575fc345d7mr3356106vsj.53.1657808631159; Thu, 14
 Jul 2022 07:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com> <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
In-Reply-To: <YtAkwcwXaQqZV75d@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jul 2022 08:23:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
Message-ID: <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for output-supply
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 8:14 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 08:10:41AM -0600, Rob Herring wrote:
> > On Thu, Jul 07, 2022 at 10:18:24AM +0200, Naresh Solanki wrote:
> > > Add a devicetree binding for the 9elements,output-supply driver.
>
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - 9elements,output-supply
>
> > Why does this have a vendor prefix when it appears to be a s/w
> > construct?
>
> It's a description of a power supply output from their system (system as
> a whole, not power provisioned within the system).

Well, that's a better commit message than the original, but I still
don't understand.

Rob
