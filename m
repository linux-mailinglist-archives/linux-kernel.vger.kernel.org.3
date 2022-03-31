Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7E4EE47D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiCaXLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCaXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:11:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EC381B7;
        Thu, 31 Mar 2022 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4pi6Yofki9Qeq8sx7w1jYYKBaA6jG7OQJFfRxFBrIaY=; b=Ignb8HlQvHXxHKYIvWLc0h3Uox
        NbuMQbxfwddanlJRyaezuTocz9d1c5e9Ug1IRIAnvDtD6wwqXr7TQT1XGH42wsRlZqSSOwfo+OIJY
        S+0MiBCvfyOf0WWg6HZd9P2yilLXr/R9Jq6SOFyby+3q9z5QkCIUOjbtHD0SXHmrU+B6du1233cGY
        1Dstj2M7+PcP/PgW4y5f67AM84B8JFQks8JM1SpMza1pV8giTW33dw/dx+MgKLqTkFOilSJvP5AHm
        B0DpMl15gJe2s/eXblxaLTVvag690U2YxFOvbRML/efTiIjYcMFJXtIBpLuYq/jcRo2J0fNEU/vrB
        J8Caj8kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na3ue-000BRG-Qa; Thu, 31 Mar 2022 23:09:10 +0000
Message-ID: <7c6c1f19-c16b-eb70-0ee8-2c6a046d002e@infradead.org>
Date:   Thu, 31 Mar 2022 16:09:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: nxp: RB532: fix return value of __setup handler
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org
References: <20220331230728.13897-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220331230728.13897-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, sorry, wrong Subject line.
Will resend.


On 3/31/22 16:07, Randy Dunlap wrote:
> imx-mipi-csis uses interfaces that are made available by VIDEO_DEV,
> so the driver should depend on VIDEO_DEV to eliminate build errors.
-- 
~Randy
