Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316D59C8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiHVTVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiHVTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:20:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7CF587
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE787B818AB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA6C43140
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196010;
        bh=YAfavG/ehhE5NO9shqEPNYUydHcq4aFWFE3Ux0//VA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WPRq9dFpR2DmM5QiwIT7sJgAJYG0vpVHHuV86AODxSCo0brrLcrp76MF8TmtVDs4r
         diJ05stN5YM3Cde8QcG7AUKCcy9gQDCHAkUff+fIRNn7syZp+ICWfo2uA1xfhVO1zs
         gNV08PtgROWIRN7W+EektUH7u+3Fm2dyWLG3jm97njwmc7ZkRuPDNgyU1ZFt6/I4p8
         xuNJhtnzcAnf3JdGr5FTpvgt+nN4TG7V6odd01vhLP4yHe0BimP3vyq1a0ZgEt6DT1
         QOrh7Eon2QtwvwbpnNKc3HkNkkfHibSWakxGivSB036tU+obf554oQWun5dQzMrGtX
         ADo9L4pcBFzgw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11c4d7d4683so14079986fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:20:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo0WZRRRtleRwCOtnZBnBPOdnWcdT+jYwfbqJmBqwWv4xMz3qs9c
        LVya/J2shwBAHETjo8P7ailxd/3lotLLcvL4TWo=
X-Google-Smtp-Source: AA6agR7fxD/zVMg/15SFvG+w3nBNLTDtCCSgMdmUk5wkoIsi8amKFTENTNYHD5eQOv4iMvq07aklOAvHZpcIssiA1a4=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr9771332oaq.166.1661196009638; Mon, 22
 Aug 2022 12:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220821080608.27486-1-ogabbay@kernel.org> <20220822105240.3cb3002c@gandalf.local.home>
In-Reply-To: <20220822105240.3cb3002c@gandalf.local.home>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 22 Aug 2022 22:19:42 +0300
X-Gmail-Original-Message-ID: <CAFCwf131743JdP=jETiEaZUbKDHVXZ_=-uc1-_RfT-91_XPyDw@mail.gmail.com>
Message-ID: <CAFCwf131743JdP=jETiEaZUbKDHVXZ_=-uc1-_RfT-91_XPyDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Adding support for trace events to habanalabs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 5:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 21 Aug 2022 11:06:05 +0300
> Oded Gabbay <ogabbay@kernel.org> wrote:
>
> > Thanks for your comments. We have fixed the patches according to them.
> >
> > You wrote the first patch is r-b, but I took the liberty to add your r-b to
> > all three patches, I hope you don't object.
>
> I usually only add the r-b to the patches that add TRACE_EVENT(), and
> sometimes to those that modify them. Because that's what I know best. The
> usage of the trace events is usually subsystem specific and I tend not to
> add a r-b for them because people might think I understand how they are
> being used ;-)
>
> But in this case, since I did recommend some tricks in those extra patches,
> you can keep the tag for them.
>
> Here's my disclaimer for all these patches:
>
> ***
>
> Reviewed only from the tracing point of view, I have no idea if the content
> held in the trace is correct or not.
>
> ***
>
> ;-)
>
> -- Steve

Disclaimer duly noted Steve ;-)
Thanks for the review.

Oded
