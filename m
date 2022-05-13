Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A4525C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377797AbiEMHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352114AbiEMHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767D64BCA;
        Fri, 13 May 2022 00:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCF3CB82C44;
        Fri, 13 May 2022 07:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FFC34100;
        Fri, 13 May 2022 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652426624;
        bh=4j63qxQv6bBPt6Zh+ZWZmN70Zaw28P37OyeOwv5c/Oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFyf0r+jwlAxjvj7Sk8arQc3WwE7ti3QUVyvSibylKDucSVUrODGUnSLKNQU60Vea
         c0G2o8jiMF8I0ZkSoXo7Aq4+OITclZIgF7H45q/xOlUt1AijIJ3J3DD3I3dl6oxQ3J
         O6OQ/RaPdkDgwGO1BEPhtOA6MsMEpBiivgBKIryG1TT8AQrhl9BX4TOdsBIuCTHVsm
         d/AiIF+dT5pLk+suc058p7yFuk11dBe5TARH8/T4ZIz2li8IVKn3fOmnRrFZGpuHRr
         qjnO8Q9jfnpObbgM3HM4BbgOakBoXlXKW3jfDj6gthTSGRyXxYwQi5olgS4bYfMq0Q
         Ja4H52FoTl9ZA==
Date:   Fri, 13 May 2022 09:23:39 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     <lukas.bulwahn@gmail.com>, <bin.liu@mediatek.com>,
        <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
Subject: Re: [PATCH RFC] MAINTAINERS: drop unreachable contact for MEDIATEK
 JPEG DRIVER
Message-ID: <20220513092339.60f9eedc@coco.lan>
In-Reply-To: <20220309030431.31247-1-miles.chen@mediatek.com>
References: <20220308114300.12502-1-lukas.bulwahn@gmail.com>
        <20220309030431.31247-1-miles.chen@mediatek.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 9 Mar 2022 11:04:31 +0800
Miles Chen <miles.chen@mediatek.com> escreveu:

> Hi Lukas,
> 
> > After sending a patch to Rick Chang, the mediatek mail server responded:
> > 
> >   ** Message not delivered **
> > 
> >   Your message couldn't be delivered to rick.chang@mediatek.com because
> >   the remote server is misconfigured. See technical details below for more
> >   information.
> > 
> >   The response from the remote server was:
> >   550 Relaying mail to rick.chang@mediatek.com is not allowed
> > 
> > So, drop Rick Chang from the MEDIATEK JPEG DRIVER section.

Funny... I did a quick test here, and the e-mail to Rick was not rejected:

Connecting to smtp.kernel.org [35.85.114.177]:587 ...  TFO mode sendto, no data: EINPROGRESS
 connected
  SMTP<< 220 smtp.kernel.org ESMTP Postfix
  SMTP>> EHLO mail.kernel.org
  SMTP<< 250-smtp.kernel.org
         250-PIPELINING
         250-SIZE 30720000
         250-VRFY
         250-ETRN
         250-STARTTLS
         250-ENHANCEDSTATUSCODES
         250-8BITMIME
         250-DSN
         250 CHUNKING
  SMTP>> STARTTLS
  SMTP<< 220 2.0.0 Ready to start TLS
  SMTP>> EHLO mail.kernel.org
  SMTP<< 250-smtp.kernel.org
         250-PIPELINING
         250-SIZE 30720000
         250-VRFY
         250-ETRN
         250-AUTH PLAIN LOGIN
         250-ENHANCEDSTATUSCODES
         250-8BITMIME
         250-DSN
         250 CHUNKING
  SMTP>> AUTH PLAIN ************************************
  SMTP<< 235 2.7.0 Authentication successful
  SMTP|> MAIL FROM:<mchehab@kernel.org> SIZE=1361 AUTH=mchehab@kernel.org
  SMTP|> RCPT TO:<rick.chang@mediatek.com>
         will write message using CHUNKING
  SMTP+> BDAT 338 LAST
  SMTP>> QUIT
  SMTP<< 250 2.1.0 Ok
  SMTP<< 250 2.1.5 Ok
  SMTP<< 250 2.0.0 Ok: 338 bytes queued as 8DCF4C34100
  SMTP<< 221 2.0.0 Bye
  SMTP(close)>>
LOG: MAIN
  => rick.chang@mediatek.com R=smarthost T=remote_msa H=smtp.kernel.org [35.85.114.177] X=TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256 CV=yes A=client_auth_plain K C="250 2.0.0 Ok: 338 bytes queued as 8DCF4C34100"
LOG: MAIN
  Completed

> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>  
> 
> I confirmed that Rick Chang has left Mediatek, so it is ok to remove his name.

Ok, I'll apply the patch.

> 
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> 
> Thanks,
> Miles

Thanks,
Mauro
