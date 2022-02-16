Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593784B945C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiBPXOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:14:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:14:32 -0500
X-Greylist: delayed 86664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 15:14:18 PST
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A503E2AA3BC;
        Wed, 16 Feb 2022 15:14:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D0A98784;
        Wed, 16 Feb 2022 23:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0A98784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645053258; bh=Ii91PbTizUvlQDl00HRhyNU7ps2F0sUdCdHVbWT2xj4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NG5HIv+jYjDlvsF6FPKjrmM1XtT0KEETbOdLjeN5riijpgWSE85EU0s53+4c0uYtn
         7mNafYk+yDiC0F2wbEs/wgyhNIgtyCGjwD7Tt2rLsuUCFFqTsqlmROkr6MqWbljEQS
         JyhRjNml9Go2pYlWxMXYoTt05uKnNnpNKv+Etd1zdFm4G7VJbnqV1ly8MEfrifXlHd
         ddeIV360EJnh3eCuNPc+k6aDEt6P2LawNpJsCiZlAmJMvBEKiKesHXMhXwvTBTV8sd
         kM8eqwWgqD3jU/m2n2bqzJeOW48MU9r62NbXyXROKQfFBm2Bu2dXuscj0rtSHHiq3f
         PsgNLo2kntVDw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Transform documentation into POD
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:14:17 -0700
Message-ID: <871r024d6e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> This series transforms the free-form general comments - mainly the usage
> instructions and the meta information - into the standard Perl
> documentation format. Some of the original text is reduced out.
>
> The transformation includes language, paragraphing and editorial
> corrections.

OK, so I'm finally getting back to these, apologies again for the
unreasonable delay.  I do think that the work to this point is
worthwhile, and we should be able to get it in for 5.18.  I will have a
number of comments on the individual patches, though.

Thanks,

jon
