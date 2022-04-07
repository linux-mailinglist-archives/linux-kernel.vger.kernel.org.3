Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB10F4F7CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiDGK2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiDGK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D675E51
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A2461D70
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD6C385A0;
        Thu,  7 Apr 2022 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649327172;
        bh=MyUf7AujTEpxUKvaGD759rpg/Yogr0VeCaX00bISGdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsIlNmmmWcUFxh3QtvKJ8Ptxs24xYVmP5WgxTkSjzdIkBt1wjx/T5O58ICEZsD+90
         db+tSqh3Tgvj00JTLMhkR76nU+PrO7X1o/w6eqnfSfEz2Hlp+L2UeLvwlWDrrpeWIQ
         Z2vLy35Y0lVWtHD12/n8WL8wdZfLPl6vbXUhKXe5Klz+oqN/LbzItiucyF7Pijk3Nu
         wHamh35Sz+wGn5Jx2xbe3cqIsd5c2yESap61b1JRgo778r5JR0ad+ip71DzcikN4Xf
         G6rJPtTchjEPmj3m7j7LV2QVpywCoYHyYWOoN2DCMYFWA9NiB7xTkp7xTLWrmSmK2v
         Gx8cLGGRpdANg==
Date:   Thu, 7 Apr 2022 12:26:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, guobing.chen@intel.com, ming.a.chen@intel.com,
        frank.du@intel.com, Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ovl]  30f9ef9479: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20220407102605.ipstobkadq34gmzg@wittgenstein>
References: <20220407094023.GA13500@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407094023.GA13500@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:40:23PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 30f9ef94795008e5146f69d2eb043922a512bf85 ("ovl: support idmapped layers")
> https://github.com/ammarfaizi2/linux-block brauner/linux/fs.idmapped.overlayfs.v3

That's an old branch. :)
Anything that has a *.v<idx> appended is basically an old version in my
tree. The base branch is always the branch name without the *.v<idx>
suffix.

Thanks!
Christian
