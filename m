Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802425A092D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiHYGwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHYGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:52:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408C392;
        Wed, 24 Aug 2022 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410336; x=1692946336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=04yCuX7p5BBTYeA/TynP8rNdpmcbvJolmE3P3S679tg=;
  b=icyhS006ssW4/OjidFoOp/M8szSIkdaJy4ebIYhAjSkczRuGDzRD784r
   IUIeKRhvGH50Rc95VMXQfFAffCdECuPn3IkhEzn0t0Z/keIk2JdD9XJ9Z
   rgUfLY65MycICMZmHFdGWk/QAxzBX0mLgSTAE80Aiw5qSsSWDmdn4YK5C
   Af9ztmtnBpB2qiJB2+uSoUjE4WcDxCBh2XzDPc/FdA917xihen0DNCCvP
   vCNyvzDjY+wOrtrnRpUZ5hDKYgTBKQefP8Vjp5i+eMxJ4Q4UczbCiYxUM
   atxwVeBPdZvH2qVw1si83154g7LzU9Lvkvjv4oJIDSUmdCjCy0KNqfEP1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291731398"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291731398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:52:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670847341"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:52:14 -0700
Message-ID: <657c3398-36fc-0a0a-22c2-f749e1b5d8e5@intel.com>
Date:   Thu, 25 Aug 2022 09:52:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf tools man pages on the web
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, John Kacur <jkacur@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
 <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
 <YvzrYLx3RDHAmqbf@kernel.org>
 <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/22 19:24, Arnaldo Carvalho de Melo wrote:
> 
> 
> On Wed, Aug 17, 2022, 10:21 AM Arnaldo Carvalho de Melo <acme@kernel.org <mailto:acme@kernel.org>> wrote:
> 
>     Em Wed, Aug 17, 2022 at 06:02:25AM -0700, Ian Rogers escreveu:
>     > On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>> wrote:
>     > > Speaking of the wiki, anyone know how to change the
>     > > "Set $wgLogo to the URL path to your own logo image." image?
> 
>     > +1000
> 
>     > Someone at RedHat knows :-)
> 
>     Documentation is at the Media Wiki site, admin up to a point was John Kacur,
>     John?
> 
>     https://www.mediawiki.org/wiki/Manual:FAQ#Changing_the_interface <https://www.mediawiki.org/wiki/Manual:FAQ#Changing_the_interface>>
> 
>     --------------------- 8< ----------------------------------
> 
>     How do I change the logo?
> 
>     The logo that appears in the top left of each page is determined by the $wgLogo configuration line in the LocalSettings.php file.
> 
>     There are two ways to change the logo:
> 
>         Upload a picture to your wiki using the normal file uploading interface. This allows the logo to be replaced easily, so you may want to protect the page if you use this method.
> 
>             Then add the $wgLogo line to LocalSettings.php, for example:
> 
>             $wgLogo = "{$wgUploadPath}/6/62/mylogo.png";
> 
>         Upload an image to your server by other means (such as FTP).
> 
>             Add the $wgLogo line to LocalSettings.php, for example:
> 
>             $wgLogo = "{$wgScriptPath}/mylogo.jpg";
> 
>             (In this example, the image is in the same folder as the LocalSettings.php file.)
> 
>     If you want to change the logo in only specific pages, override #p-logo
>     css's background-image property or use third party extension like
>     Extension:LogoFunctions.  Caution! Caution:     Do not simply overwrite
>     the default logo installed with MediaWiki (/resources/assets/wiki.png);
>     this file will be overwritten when you upgrade.  A good size for a
>     square logo is 135x135px or 150x150px, but the logo need not be square,
>     especially if it contains text below an image. The maximum logo size in
>     Vector is ~160x160px, while MonoBook's is ~155x155px. A logo that is too
>     large will be cut off.
> 
>     --------------------- 8< ----------------------------------
> 
> 
> I got it sorted out with the kernel.org <http://kernel.org> admins.
> 
> Please force reload.

Is it just me or has it disappeared again?


