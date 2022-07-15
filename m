Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EB576807
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGOUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiGOUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:16:09 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1F4598A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:16:07 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oCRjG-0006Zz-Rp; Fri, 15 Jul 2022 22:16:02 +0200
Date:   Fri, 15 Jul 2022 22:16:02 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: r8188eu: remove SetHwReg8188EU()
Message-ID: <20220715201602.bnmexv2uzmnkusjf@viti.kaiser.cx>
References: <20220715062908.8547-1-straube.linux@gmail.com>
 <20220715062908.8547-6-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715062908.8547-6-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thus wrote Michael Straube (straube.linux@gmail.com):

> Remove the case HW_VAR_CORRECT_TSF from SetHwReg8188EU() and move the
> functionality to the function that calls SetHwReg8188EU() with
> HW_VAR_CORRECT_TSF. SetHwReg8188EU() is empty now and we can finally
> remove it.

nice work :-)

For the whole series:
Tested-by: Martin Kaiser <martin@kaiser.cx>
