Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A3596FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbiHQNWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiHQNVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400580EBE;
        Wed, 17 Aug 2022 06:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97BC6130F;
        Wed, 17 Aug 2022 13:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D4FC433C1;
        Wed, 17 Aug 2022 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660742499;
        bh=h4GXGKaQaNJOaFx5e5DFot02bgz0zhhO3WPRqCaKCzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUVUg/JR5mlDYRP4D/zT4mFFkjO3HGHnNdmUpDLUFpAK/LpYUcUD2YMWFeMdZ3sg4
         5ZW7OGjYCZ0zq5RWB/WQoO88q1wm1et1tErGGKZ38a/Et5uYiuzWlaUZ5+do6uBBs9
         Xx9g6yXjNZA48/Gg1lvyih/ZAaS4zcc/kdqr4vz9jF/LNRNCkU+3BC5IuAmq+/yb/V
         sEZ9rcUG9idpjmLqHXSCzhGN29JV3Df0WhFBRWnwio2VF0VggkODbd3wPpru5JuUvq
         AiyRW3iAW2eGyW6klN3g82+pRNLC+dE7OALI5ct/fCTW+D8+EGGwUjxzB11dvkigXC
         wl5X/gVvF1paw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C78434035A; Wed, 17 Aug 2022 10:21:36 -0300 (-03)
Date:   Wed, 17 Aug 2022 10:21:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, John Kacur <jkacur@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: perf tools man pages on the web
Message-ID: <YvzrYLx3RDHAmqbf@kernel.org>
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
 <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 17, 2022 at 06:02:25AM -0700, Ian Rogers escreveu:
> On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > Speaking of the wiki, anyone know how to change the
> > "Set $wgLogo to the URL path to your own logo image." image?
 
> +1000
 
> Someone at RedHat knows :-)

Documentation is at the Media Wiki site, admin up to a point was John Kacur,
John?

https://www.mediawiki.org/wiki/Manual:FAQ#Changing_the_interface>

--------------------- 8< ----------------------------------

How do I change the logo?

The logo that appears in the top left of each page is determined by the $wgLogo configuration line in the LocalSettings.php file.

There are two ways to change the logo:

    Upload a picture to your wiki using the normal file uploading interface. This allows the logo to be replaced easily, so you may want to protect the page if you use this method.

        Then add the $wgLogo line to LocalSettings.php, for example:

        $wgLogo = "{$wgUploadPath}/6/62/mylogo.png";

    Upload an image to your server by other means (such as FTP).

        Add the $wgLogo line to LocalSettings.php, for example:

        $wgLogo = "{$wgScriptPath}/mylogo.jpg";

        (In this example, the image is in the same folder as the LocalSettings.php file.)

If you want to change the logo in only specific pages, override #p-logo
css's background-image property or use third party extension like
Extension:LogoFunctions.  Caution! Caution: 	Do not simply overwrite
the default logo installed with MediaWiki (/resources/assets/wiki.png);
this file will be overwritten when you upgrade.  A good size for a
square logo is 135x135px or 150x150px, but the logo need not be square,
especially if it contains text below an image. The maximum logo size in
Vector is ~160x160px, while MonoBook's is ~155x155px. A logo that is too
large will be cut off.

--------------------- 8< ----------------------------------

- Arnaldo
