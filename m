Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172B65147F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358248AbiD2LVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiD2LVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717085667;
        Fri, 29 Apr 2022 04:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84F63B83452;
        Fri, 29 Apr 2022 11:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F78C385A4;
        Fri, 29 Apr 2022 11:18:19 +0000 (UTC)
Message-ID: <71e4aded-7c42-02c0-b0d2-b3078e76a287@xs4all.nl>
Date:   Fri, 29 Apr 2022 13:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V0 1/1] media: v4l2-core: Enable reserved field of
 v4l2_event
Content-Language: en-US
To:     Naina Vaskenly <quic_nvaskenl@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        lijian <lijian@yulong.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Anshuman <quic_anshuk@quicinc.com>
References: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 13:06, Naina Vaskenly wrote:
> 'reserved' member of struct v4l2_event is currently not enabled.
> This field can be used to transfer data, if >64 bytes of data
> has to be sent. Hence, added this change to copy the reserved field in
> __v4l2_event_queue_fh.
> 
> Naina Vaskenly (1):
>   media: v4l2-core: Enable reserved field of v4l2_event
> 
>  drivers/media/v4l2-core/v4l2-event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

No patch?

Regards,

	Hans
