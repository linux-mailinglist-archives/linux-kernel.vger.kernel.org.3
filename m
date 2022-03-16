Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AA4DADF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355072AbiCPJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350863AbiCPJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:57:08 -0400
X-Greylist: delayed 2292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 02:55:53 PDT
Received: from bitmer.com (49-237-179-185.static.tentacle.fi [185.179.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C955771;
        Wed, 16 Mar 2022 02:55:53 -0700 (PDT)
Received: from jarkko by bitmer.com with local (Exim 4.89)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1nUPmO-0007RG-Tx; Wed, 16 Mar 2022 11:17:16 +0200
Date:   Wed, 16 Mar 2022 11:17:16 +0200
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: Fix spelling mistake "cant" -> "can't"
Message-ID: <20220316091716.wk25xjliy4zzvzb3@bitmer.com>
References: <20220315230816.2964577-1-colin.i.king@gmail.com>
 <4d3c65c0-1bc3-bc8f-393a-22c964f18120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3c65c0-1bc3-bc8f-393a-22c964f18120@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 08:34:12AM +0200, Péter Ujfalusi wrote:
> 
> 
> On 16/03/2022 01:08, Colin Ian King wrote:
> > There is a spelling mistake in a dev_err message. Fix it.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
