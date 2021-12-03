Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61154467109
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbhLCEN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbhLCEN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:13:26 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC2C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:10:02 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id q64so2209952qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 20:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G03Bg9mTbcDJu1/QL9hBZCtHuqV9yBXy6ux9CJibey4=;
        b=bsEwGmmgf3txjglpzc5YaAeR4W/oyU1/zOUTXDpJEiYetY7SY62/raSqON9gmUIUlO
         pIaF83D6yBL+YIf0k+fPrwFiu8RGvAo9fMnqsVFfdTvuMwuJ1/n9yaFkOzCknc/grbD8
         wFd/iCeaO512Wvko11rRHcQLa0Pc4A5MNi2YgGkQDnXt+aAc6t5yPLAQn6IIJIyAXGPD
         oLNY7r0mElPAYns97rN9VRcQV/S7mJXlIf7lk2bdLQ9dDY3XzKOR7AzRTRM4yGGe64DE
         bLbuRcFFeitDq7MPircuDFOirWW7a8MgSPiBfhBWZccsijmvYUJFZDWN2NDw0Fkkt6uz
         U6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G03Bg9mTbcDJu1/QL9hBZCtHuqV9yBXy6ux9CJibey4=;
        b=UGQTS0JEWoBoNmc6ua57ODQ8/vXGXV4DwhBo6byRWaFyiZu3Kwl2DDLLknsIFxahNt
         85EcFN9L5SOV23OhzAjNwZ98J5PJkGGqtmxFcRi/vHBXrQgLPc7Pg01+1t15lKbe5C24
         Rxu8WQykCOla0PxCH6gzZEHT2J/MW5ugbdtk6Oe/9DqRsJqeR0Ez9JjyuWDYKgcdOD8K
         VJodz+XaWkQQUAnmMVE9pQbpt/Syf01b5jmY9M90ckJtR+cddgFk/9wlQLbQvGpG03Um
         xoRCYT5WCaCIlAbjGtOdoolA2uA6MLmqJVQuZPC2YFbr8lgOpgyH44n8z3XIQSkcFEkl
         eb7A==
X-Gm-Message-State: AOAM533z+mwX0x90k+l7ihhsm9l7+Yd+/+8HneCR2qqet4m6WpA7dRWB
        BZKmRqyY0HfmM59A108OLVtt2w==
X-Google-Smtp-Source: ABdhPJy3lE+zu/WVZLgfUkQvuqOJwbFKWmqUTJpWqvRPMzY5LH3zWKkSuJbd0Fpv/Y2ZoYYy7lCd0Q==
X-Received: by 2002:a05:620a:f07:: with SMTP id v7mr15253259qkl.289.1638504601624;
        Thu, 02 Dec 2021 20:10:01 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id h3sm1456297qko.78.2021.12.02.20.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:10:01 -0800 (PST)
Message-ID: <a77c2fca8bd1e95e1948d3fa98fe106c228221c7.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v12 00/13] amphion video decoder/encoder driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 02 Dec 2021 23:09:59 -0500
In-Reply-To: <DB8PR04MB6346B64E4129D81BA0CF0A1CE7639@DB8PR04MB6346.eurprd04.prod.outlook.com>
References: <cover.1636445575.git.ming.qian@nxp.com>
         <9947131322e034bb6336802e5afb4b6132ca5071.camel@ndufresne.ca>
         <AM6PR04MB6341BF1FB2A839961DBADF4EE7619@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <9b7fd6802c89c5d3bb6a42b44f13a90f6c3caf22.camel@ndufresne.ca>
         <AM6PR04MB6341F599A97253C1BA812467E7629@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <0deb3fa15dd162d7c7b6dbe24821fdf9523dddd3.camel@ndufresne.ca>
         <DB8PR04MB6346B64E4129D81BA0CF0A1CE7639@DB8PR04MB6346.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 26 novembre 2021 à 06:31 +0000, Ming Qian a écrit :
> > -----Original Message-----
> > From: Nicolas Dufresne [mailto:nicolas@ndufresne.ca]
> > Sent: Thursday, November 25, 2021 11:36 PM
> > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> > shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> > Cc: hverkuil-cisco@xs4all.nl; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v12 00/13] amphion video decoder/encoder
> > driver
> > 
> > Caution: EXT Email
> > 
> > Le jeudi 25 novembre 2021 à 05:25 +0000, Ming Qian a écrit :
> > > For test [JCT-VC-HEVC_V1] (GStreamer-H.265-V4L2-Gst1.0)
> > > VPSSPSPPS_A_MainConcept_1, The vpu report an unsupported message to
> > driver, so driver report pollerr to gstreamer.
> > > But this stream can be decoded using the amphion vpu when I test it
> > > using our unit test, I checked the difference, there are many vps, sps
> > > and pps at the beginning, gstreamer will skip the first vpu and two
> > > pps, totally skip 56 bytes. It leds to vpu can't decode And our unit test
> > > won't
> > skip anthing, so the vpu can decode the stream.
> > 
> > This specific test triggers a bug in GStreamer HEVC parser, I'm aware of
> > this
> > one, and it is on my todo to fix (just not as trivial as it looks like, the
> > VCL nal
> > detection code was implemented wrong and that ended up leaking into the
> > rest of the design). This specific test will of course be marked and skipped
> > for CI
> > test that uses GStreamer.
> > 
> > regards,
> > Nicolas
> 
> Hi Nicolas,
> 
>     For the h264 decoder test, If I test with our unit test tool, the result
> is 124/135 tests successfully,
> But only 75/135 tests successfully when test using gstreamer.
>     There are 49 tests with different results, and all of the 49 test streams
> are interlaced stream.
> The amphion vpu will output the interlaced frame directly, it won't merge the
> interlaced two parts into one progressive frame.
>      And the gstreamer tiled unpack function(unpack_NV12_TILED) won't handle
> the interlaced case, so the output frame is abnormal, and led to test fail.
>      I think it should be a hardware limitation of the amphion vpu. And maybe

If this is the case, it needs to be signaled as ALTERNATE (if you have 1 v4l2
buffer per field) or SEQ if they are stored in the same v4l2_buffer but on top
of each other instead of interleaved.

Some bit about this might not we all wired properly, I have only tested
alternate field for capture devices (Xilinx ZinqMP). Please check the signalling
of interlace field in your driver, I'll check the state of GStreamer in this
regard.

> the gstreamer videoconvert can handle it.
> The interlaced list is as below:
> [JVT-AVC_V1] cabac_mot_fld0_full
> [JVT-AVC_V1] cabac_mot_mbaff0_full
> [JVT-AVC_V1] cabac_mot_picaff0_full
> [JVT-AVC_V1] CABREF3_Sand_D
> [JVT-AVC_V1] CAFI1_SVA_C
> [JVT-AVC_V1] CAMA1_Sony_C
> [JVT-AVC_V1] CAMA1_TOSHIBA_B
> [JVT-AVC_V1] CAMA3_Sand_E
> [JVT-AVC_V1] CAMACI3_Sony_C
> [JVT-AVC_V1] CAMANL1_TOSHIBA_B
> [JVT-AVC_V1] CAMANL2_TOSHIBA_B
> [JVT-AVC_V1] CAMANL3_Sand_E
> [JVT-AVC_V1] CAMASL3_Sony_B
> [JVT-AVC_V1] CAMP_MOT_MBAFF_L30
> [JVT-AVC_V1] CAMP_MOT_MBAFF_L31
> [JVT-AVC_V1] CANLMA2_Sony_C
> [JVT-AVC_V1] CANLMA3_Sony_C
> [JVT-AVC_V1] CAPA1_TOSHIBA_B
> [JVT-AVC_V1] CAPAMA3_Sand_F
> [JVT-AVC_V1] cavlc_mot_fld0_full_B
> [JVT-AVC_V1] cavlc_mot_mbaff0_full_B
> [JVT-AVC_V1] cavlc_mot_picaff0_full_B
> [JVT-AVC_V1] CVCANLMA2_Sony_C
> [JVT-AVC_V1] CVFI1_Sony_D
> [JVT-AVC_V1] CVFI1_SVA_C
> [JVT-AVC_V1] CVFI2_Sony_H
> [JVT-AVC_V1] CVFI2_SVA_C
> [JVT-AVC_V1] CVMA1_Sony_D
> [JVT-AVC_V1] CVMA1_TOSHIBA_B
> [JVT-AVC_V1] CVMANL1_TOSHIBA_B
> [JVT-AVC_V1] CVMANL2_TOSHIBA_B
> [JVT-AVC_V1] CVMAPAQP3_Sony_E
> [JVT-AVC_V1] CVMAQP2_Sony_G
> [JVT-AVC_V1] CVMAQP3_Sony_D
> [JVT-AVC_V1] CVMP_MOT_FLD_L30_B
> [JVT-AVC_V1] CVMP_MOT_FRM_L31_B
> [JVT-AVC_V1] CVNLFI1_Sony_C
> [JVT-AVC_V1] CVNLFI2_Sony_H
> [JVT-AVC_V1] CVPA1_TOSHIBA_B
> [JVT-AVC_V1] FI1_Sony_E
> [JVT-AVC_V1] MR6_BT_B
> [JVT-AVC_V1] MR7_BT_B
> [JVT-AVC_V1] MR8_BT_B
> [JVT-AVC_V1] MR9_BT_B
> [JVT-AVC_V1] Sharp_MP_Field_1_B
> [JVT-AVC_V1] Sharp_MP_Field_2_B
> [JVT-AVC_V1] Sharp_MP_Field_3_B
> [JVT-AVC_V1] Sharp_MP_PAFF_1r2
> [JVT-AVC_V1] Sharp_MP_PAFF_2r
> 

