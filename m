Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978A558A070
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiHDSY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:24:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955B6C11A;
        Thu,  4 Aug 2022 11:24:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j1so741873wrw.1;
        Thu, 04 Aug 2022 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P2i3nVr7s3AxkpiqSAwoUx2UCfTEKlc1R/y0JQMWa1k=;
        b=S9ijxXJOTmw9wynz1lTfdN1ne/uVFKTW/lpsxyXRMisCxIJKCcpFcInwk+q+4wMwSX
         hafK0i4FbkMcm/4HpPpcYN5q63XRGL4NgkMujdO5VPWO3DjYFWjMkriMT6NIW1YqAv20
         f0Jil9q/iEImBd88aM8TEkPfcTxPBwFUpy2rlzTRTGZVyTOpIgDLi14+ylpYVbS6kLYt
         /x76veoxSOMdp8r7J4lhY9Mbf33ohWpcyElqypM8D7UcHO9rgFmewRWlq9sQy1hTMCMj
         wwVjIvnvR35vKmUXySRMsa24fOFT8S50Om+afoNlN+TBgwll/ELUeMRC371qTjWJ8i5p
         qRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P2i3nVr7s3AxkpiqSAwoUx2UCfTEKlc1R/y0JQMWa1k=;
        b=H2SgkOA4Qunc2nj0W/GbRUYeUFRhK8AmdKvNt1ocQVUSW58jrKBOm7EtYPwTF/Q6EQ
         Z+2EsvmoIcrVX++1z3iE356bNa9dluDygd/TwWP9NSRQtLU2sSUKBt7Lv5CzF7Q0GKMp
         KK5MZkISthjcG4Ahc8mgr0LOwORzP6pWjxv/+cb4/EOAmVVqwoijfwGdbgH5Czmw0lYh
         1N+Yu/wYcyiphL77Ve5HNccFZwGhY3oG6Ot7W+VWi0OYD1ReGQg+99OwIcwElwFT91s1
         Rqx/ghtr3Q0EIvI8b6dadoZWo45OMbDgut7RvL2spzbIE6AcfyvrqGUGTqy3DsyieV/b
         Dvxg==
X-Gm-Message-State: ACgBeo2pJmmMNn05sHv9irVsJSa2zQUXANg7wX9FDMMVXVMMYv89cI6b
        kFeXr6YclSX3S+7F4km3aWNUXIRZFAu7TA==
X-Google-Smtp-Source: AA6agR61wmZfKhEeqr+/s22JFKpwQKUANfrWC6LpK9BRNAM+xNat8fMyXP3nIsQOutsedLUxu/orag==
X-Received: by 2002:a5d:64ca:0:b0:220:6247:42c1 with SMTP id f10-20020a5d64ca000000b00220624742c1mr2193422wri.478.1659637491092;
        Thu, 04 Aug 2022 11:24:51 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b003a32167b8d4sm7610384wmm.13.2022.08.04.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:24:50 -0700 (PDT)
Date:   Thu, 4 Aug 2022 20:24:45 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220804182445.GA16569@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 2022-07-26 18:48, José Expósito wrote:
> The first bad commit is 87562fcd1342 ("HID: input: remove the need for
> HID_QUIRK_INVERT"):
> https://lore.kernel.org/all/20220203143226.4023622-11-benjamin.tissoires@redhat.com/
> (CCing the folks whose email is in the patch tags)
> 
> I reverted the patch on hid/for-next and, after fixing a tiny conflict,
> I can confirm that the tablet works again as expected.
> 
> I'd need to investigate a bit more over the weekend, but I think that
> all HUION tablets with the latest firmware (internally, v2) are
> affected.

Indeed, it looks like v2 devices are affected. Similar reports:

 - https://github.com/DIGImend/digimend-kernel-drivers/issues/626
 - https://bugzilla.kernel.org/show_bug.cgi?id=216106

Kindly sending this thread back to your inbox to see if we could fix
this regression.

Best wishes,
Jose

> Those tablets do not set the inrange bit (UCLOGIC_PARAMS_PEN_INRANGE_NONE).
> The driver sets it and uses a timer to remove it.
> See drivers/hid/hid-uclogic-core.c, function uclogic_raw_event_pen().
> [...]
