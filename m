Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC953588C09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiHCM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiHCM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308DF57270;
        Wed,  3 Aug 2022 05:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8F05B82258;
        Wed,  3 Aug 2022 12:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D99C433C1;
        Wed,  3 Aug 2022 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529590;
        bh=gXkbbL4x75dYnAlYPQxV4R73v+dDewWOi3hfCByvglA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fTb3dMV3xzjVw9uQh/dzT3YBMj9dBGOASR3wI23mUayd0u/WyD++aZMSkce4NCBva
         XeeqN10A7Mc/YF/LUtcyK7Ciu8iewuG70MmexYsxioHJZ2dpKQTW4OQlpmI5IsO4t2
         zt1A4Xwxg5h8p9aUmxzaLon8ZRzC4IScyMgl3kdL4D2WtFaa7un+r4x/aS8Mj4P0fg
         yDThmbcgZQWqy3ZJJ9WkyGU7sXYoOazPve5D4M+aQb1v2llEFqEYfGCGHvnvw5sV8H
         mowrktM87ntrpdtUVXhhGsa8UES1tVq61VDFSt3iFnzbiAJqdRAI41qZilsVZp87nu
         KqmRvg/DwE7nA==
Message-ID: <0404b476-ce96-0c01-1380-4b6873e79a08@kernel.org>
Date:   Wed, 3 Aug 2022 15:26:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: cdns3: change place of NULL check in
 cdns3_gadget_ep_enable()
Content-Language: en-US
To:     Andrey Strachuk <strochuk@ispras.ru>,
        Peter Chen <peter.chen@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <20220728163014.247082-1-strochuk@ispras.ru>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220728163014.247082-1-strochuk@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2022 19:30, Andrey Strachuk wrote:
> If 'ep' is NULL, result of ep_to_cdns3_ep(ep) is invalid and
> priv_ep->cdns3_dev causes panic.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

Acked-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
