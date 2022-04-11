Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903B4FC1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiDKQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiDKQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2D1FCEE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66CDDCE19A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF0C385A9;
        Mon, 11 Apr 2022 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649693279;
        bh=e2IhvkA3kFkcBeSMk26cyJPywicAzd4ORpiA8q0a63Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4/LuF6XIMKp1EVb9Hl7NLIKOFo6cJ+UreZ8m5PrRymVqS8ORdAReywOXvqZXY384
         x1tYaEKQb01YDmIo7GVXNTN+9/uxTZQi+KwQuXWBD5BAiv0KpEXBPz4IgfUmhXSro/
         xTkO/tXbRgMfuh5NHKT0ruwLQXSp6iFl1RGyEyPtf+x/AgPQWMaSW727ilMdhNy2bh
         96XB4JxnCumMSOPKR2b4sicwEl4sjZ5RLTsMcb9CTJMOD2z7liM2EcXFFWS7NjS88A
         Jfn+KVQwaTne4/9E0m6xWKXXR+hUqcgWKCPUfyQL7QnhNiGe026zdcEutX/f96wafn
         HXO0SpSg34dsg==
Date:   Mon, 11 Apr 2022 18:07:54 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: turris-mox-rwtm: Fix return value check of
 wait_for_completion_timeout
Message-ID: <20220411180754.5b7ab6da@thinkpad>
In-Reply-To: <20220411104539.17971-1-linmq006@gmail.com>
References: <20220411104539.17971-1-linmq006@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 10:45:38 +0000
Miaoqian Lin <linmq006@gmail.com> wrote:

> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> indicating timeout which is the only error case
>=20
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
