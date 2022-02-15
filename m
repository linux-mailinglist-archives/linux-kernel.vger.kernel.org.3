Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6664B6490
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiBOHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:41:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiBOHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:41:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82AEAA2D2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D8D615E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F7C340EC;
        Tue, 15 Feb 2022 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644910900;
        bh=MiCBUytt8sHil7W83PmnVKvb+Q9D7bUotB7xhlbY8C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLQ2ot55/FfFJiPsI6VR5lKcHR6IsJqaFuxXQb1yfAjX1rPg4UAPFkHqTBplHTUiI
         b0GU3RjbYDJau+oxk1yg2vhAChr+Mdv2bRrdauzqKRiiifws6mzzggBDSbiAq1Y3Aw
         fYlTGV2oNnotVq3MCsVNQA68Kg6fAkSivBrldleE=
Date:   Tue, 15 Feb 2022 08:41:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     longman@redhat.com, dave@stgolabs.net, hdanton@sina.com,
        linux-kernel@vger.kernel.org, mazhenhua@xiaomi.com,
        mingo@redhat.com, peterz@infradead.org, quic_aiquny@quicinc.com,
        will@kernel.org
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <YgtZMtgPoteJqtbB@kroah.com>
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214162218.13930-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214162218.13930-1-chenguanyou@xiaomi.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:22:18AM +0800, chenguanyou wrote:
> >> Hi Waiman, Greg,
> >> This patch has been merged in branch linux-5.16.y.
> >> Can we take it to the linux-5.10.y LTS version?
> 
> >What is "this patch"?
> 
> commit d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff bit handling more consistent")

Have you tested it on the 5.10.y branch to verify it actually works
properly for you?

If so, please provide a working backport to the stable list, as it does
not apply cleanly as-is.

thanks,

greg k-h
