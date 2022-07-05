Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856456727B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiGEPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGEPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:23:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0D18E1D;
        Tue,  5 Jul 2022 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657034623; x=1688570623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfJK3Qqw5h8bvr8iCE1V0IlEhg7u3Yr4tcVq4MoHBTc=;
  b=oLDMtYIMZ64e1oNa4Z4mWCePmsIybVac0Wy3S0LBf1UeqyrEBaEDfPBC
   ekyY9jkk5mhVu06t/rDVIIuaG+I1WgdCCZ8/8ZqEW0/r2TOhzXiN/UjF1
   xIT9R5LIIJlVxe7V2L0VvA+tKEfsAcMiZ8pifdgKlhjBW7PLw66tn4c6E
   ScZ89GoJ896g825gkKacuZs94jqPWJy3Sr0ZXtS70ANK1kY4QjWXEMEHL
   NENjk30mSHIg2dymiBlvFjrQsuVonFz60a3nkL90OashbKxrabIZhecBl
   L6ttsC9bkkfW20hV8tLd890JJTTI2Tl5TC2x1C33E78z5FG+3dKR6Kod1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="266408769"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="266408769"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="625489147"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2022 08:23:39 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8kOp-000JHc-0f;
        Tue, 05 Jul 2022 15:23:39 +0000
Date:   Tue, 5 Jul 2022 23:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     kbuild-all@lists.01.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG flag
Message-ID: <202207052345.GoBCU9XT-lkp@intel.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628021909.14620-1-ming.qian@nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Qian/media-videobuf2-add-V4L2_BUF_FLAG_CODECCONFIG-flag/20220628-103906
base:   git://linuxtv.org/media_tree.git master
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/userspace-api/media/v4l/buffer.rst:614: WARNING: Bullet list ends without a blank line; unexpected unindent.
>> Documentation/userspace-api/media/v4l/buffer.rst:623: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/userspace-api/media/v4l/buffer.rst:460: WARNING: Error parsing content block for the "flat-table" directive: exactly one bullet list expected.

vim +614 Documentation/userspace-api/media/v4l/buffer.rst

 > 460	
   461	.. flat-table::
   462	    :header-rows:  0
   463	    :stub-columns: 0
   464	    :widths:       65 18 70
   465	
   466	    * .. _`V4L2-BUF-FLAG-MAPPED`:
   467	
   468	      - ``V4L2_BUF_FLAG_MAPPED``
   469	      - 0x00000001
   470	      - The buffer resides in device memory and has been mapped into the
   471		application's address space, see :ref:`mmap` for details.
   472		Drivers set or clear this flag when the
   473		:ref:`VIDIOC_QUERYBUF`,
   474		:ref:`VIDIOC_QBUF` or
   475		:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl is called. Set by the
   476		driver.
   477	    * .. _`V4L2-BUF-FLAG-QUEUED`:
   478	
   479	      - ``V4L2_BUF_FLAG_QUEUED``
   480	      - 0x00000002
   481	      - Internally drivers maintain two buffer queues, an incoming and
   482		outgoing queue. When this flag is set, the buffer is currently on
   483		the incoming queue. It automatically moves to the outgoing queue
   484		after the buffer has been filled (capture devices) or displayed
   485		(output devices). Drivers set or clear this flag when the
   486		``VIDIOC_QUERYBUF`` ioctl is called. After (successful) calling
   487		the ``VIDIOC_QBUF``\ ioctl it is always set and after
   488		``VIDIOC_DQBUF`` always cleared.
   489	    * .. _`V4L2-BUF-FLAG-DONE`:
   490	
   491	      - ``V4L2_BUF_FLAG_DONE``
   492	      - 0x00000004
   493	      - When this flag is set, the buffer is currently on the outgoing
   494		queue, ready to be dequeued from the driver. Drivers set or clear
   495		this flag when the ``VIDIOC_QUERYBUF`` ioctl is called. After
   496		calling the ``VIDIOC_QBUF`` or ``VIDIOC_DQBUF`` it is always
   497		cleared. Of course a buffer cannot be on both queues at the same
   498		time, the ``V4L2_BUF_FLAG_QUEUED`` and ``V4L2_BUF_FLAG_DONE`` flag
   499		are mutually exclusive. They can be both cleared however, then the
   500		buffer is in "dequeued" state, in the application domain so to
   501		say.
   502	    * .. _`V4L2-BUF-FLAG-ERROR`:
   503	
   504	      - ``V4L2_BUF_FLAG_ERROR``
   505	      - 0x00000040
   506	      - When this flag is set, the buffer has been dequeued successfully,
   507		although the data might have been corrupted. This is recoverable,
   508		streaming may continue as normal and the buffer may be reused
   509		normally. Drivers set this flag when the ``VIDIOC_DQBUF`` ioctl is
   510		called.
   511	    * .. _`V4L2-BUF-FLAG-IN-REQUEST`:
   512	
   513	      - ``V4L2_BUF_FLAG_IN_REQUEST``
   514	      - 0x00000080
   515	      - This buffer is part of a request that hasn't been queued yet.
   516	    * .. _`V4L2-BUF-FLAG-KEYFRAME`:
   517	
   518	      - ``V4L2_BUF_FLAG_KEYFRAME``
   519	      - 0x00000008
   520	      - Drivers set or clear this flag when calling the ``VIDIOC_DQBUF``
   521		ioctl. It may be set by video capture devices when the buffer
   522		contains a compressed image which is a key frame (or field), i. e.
   523		can be decompressed on its own. Also known as an I-frame.
   524		Applications can set this bit when ``type`` refers to an output
   525		stream.
   526	    * .. _`V4L2-BUF-FLAG-PFRAME`:
   527	
   528	      - ``V4L2_BUF_FLAG_PFRAME``
   529	      - 0x00000010
   530	      - Similar to ``V4L2_BUF_FLAG_KEYFRAME`` this flags predicted frames
   531		or fields which contain only differences to a previous key frame.
   532		Applications can set this bit when ``type`` refers to an output
   533		stream.
   534	    * .. _`V4L2-BUF-FLAG-BFRAME`:
   535	
   536	      - ``V4L2_BUF_FLAG_BFRAME``
   537	      - 0x00000020
   538	      - Similar to ``V4L2_BUF_FLAG_KEYFRAME`` this flags a bi-directional
   539		predicted frame or field which contains only the differences
   540		between the current frame and both the preceding and following key
   541		frames to specify its content. Applications can set this bit when
   542		``type`` refers to an output stream.
   543	    * .. _`V4L2-BUF-FLAG-TIMECODE`:
   544	
   545	      - ``V4L2_BUF_FLAG_TIMECODE``
   546	      - 0x00000100
   547	      - The ``timecode`` field is valid. Drivers set or clear this flag
   548		when the ``VIDIOC_DQBUF`` ioctl is called. Applications can set
   549		this bit and the corresponding ``timecode`` structure when
   550		``type`` refers to an output stream.
   551	    * .. _`V4L2-BUF-FLAG-PREPARED`:
   552	
   553	      - ``V4L2_BUF_FLAG_PREPARED``
   554	      - 0x00000400
   555	      - The buffer has been prepared for I/O and can be queued by the
   556		application. Drivers set or clear this flag when the
   557		:ref:`VIDIOC_QUERYBUF`,
   558		:ref:`VIDIOC_PREPARE_BUF <VIDIOC_QBUF>`,
   559		:ref:`VIDIOC_QBUF` or
   560		:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl is called.
   561	    * .. _`V4L2-BUF-FLAG-NO-CACHE-INVALIDATE`:
   562	
   563	      - ``V4L2_BUF_FLAG_NO_CACHE_INVALIDATE``
   564	      - 0x00000800
   565	      - Caches do not have to be invalidated for this buffer. Typically
   566		applications shall use this flag if the data captured in the
   567		buffer is not going to be touched by the CPU, instead the buffer
   568		will, probably, be passed on to a DMA-capable hardware unit for
   569		further processing or output. This flag is ignored unless the
   570		queue is used for :ref:`memory mapping <mmap>` streaming I/O and
   571		reports :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
   572		<V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
   573	    * .. _`V4L2-BUF-FLAG-NO-CACHE-CLEAN`:
   574	
   575	      - ``V4L2_BUF_FLAG_NO_CACHE_CLEAN``
   576	      - 0x00001000
   577	      - Caches do not have to be cleaned for this buffer. Typically
   578		applications shall use this flag for output buffers if the data in
   579		this buffer has not been created by the CPU but by some
   580		DMA-capable unit, in which case caches have not been used. This flag
   581		is ignored unless the queue is used for :ref:`memory mapping <mmap>`
   582		streaming I/O and reports :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
   583		<V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
   584	    * .. _`V4L2-BUF-FLAG-M2M-HOLD-CAPTURE-BUF`:
   585	
   586	      - ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF``
   587	      - 0x00000200
   588	      - Only valid if struct :c:type:`v4l2_requestbuffers` flag ``V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF`` is
   589		set. It is typically used with stateless decoders where multiple
   590		output buffers each decode to a slice of the decoded frame.
   591		Applications can set this flag when queueing the output buffer
   592		to prevent the driver from dequeueing the capture buffer after
   593		the output buffer has been decoded (i.e. the capture buffer is
   594		'held'). If the timestamp of this output buffer differs from that
   595		of the previous output buffer, then that indicates the start of a
   596		new frame and the previously held capture buffer is dequeued.
   597	    * .. _`V4L2-BUF-FLAG-LAST`:
   598	
   599	      - ``V4L2_BUF_FLAG_LAST``
   600	      - 0x00100000
   601	      - Last buffer produced by the hardware. mem2mem codec drivers set
   602		this flag on the capture queue for the last buffer when the
   603		:ref:`VIDIOC_QUERYBUF` or
   604		:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl is called. Due to
   605		hardware limitations, the last buffer may be empty. In this case
   606		the driver will set the ``bytesused`` field to 0, regardless of
   607		the format. Any subsequent call to the
   608		:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
   609		but return an ``EPIPE`` error code.
   610	    * .. _`V4L2-BUF-FLAG-CODECCONFIG`:
   611	
   612	      - ``V4L2_BUF_FLAG_CODECCONFIG``
   613	      - 0x00200000
 > 614	      - This flag may be set when the buffer only contains codec config
   615	    header, but does not contain any frame data. Usually the codec config
   616	    header is merged to the next idr frame, with the flag
   617	    ``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that will
   618	    split the header and queue it separately.
   619	    * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
   620	
   621	      - ``V4L2_BUF_FLAG_REQUEST_FD``
   622	      - 0x00800000
 > 623	      - The ``request_fd`` field contains a valid file descriptor.
   624	    * .. _`V4L2-BUF-FLAG-TIMESTAMP-MASK`:
   625	
   626	      - ``V4L2_BUF_FLAG_TIMESTAMP_MASK``
   627	      - 0x0000e000
   628	      - Mask for timestamp types below. To test the timestamp type, mask
   629		out bits not belonging to timestamp type by performing a logical
   630		and operation with buffer flags and timestamp mask.
   631	    * .. _`V4L2-BUF-FLAG-TIMESTAMP-UNKNOWN`:
   632	
   633	      - ``V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN``
   634	      - 0x00000000
   635	      - Unknown timestamp type. This type is used by drivers before Linux
   636		3.9 and may be either monotonic (see below) or realtime (wall
   637		clock). Monotonic clock has been favoured in embedded systems
   638		whereas most of the drivers use the realtime clock. Either kinds
   639		of timestamps are available in user space via
   640		:c:func:`clock_gettime` using clock IDs ``CLOCK_MONOTONIC``
   641		and ``CLOCK_REALTIME``, respectively.
   642	    * .. _`V4L2-BUF-FLAG-TIMESTAMP-MONOTONIC`:
   643	
   644	      - ``V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC``
   645	      - 0x00002000
   646	      - The buffer timestamp has been taken from the ``CLOCK_MONOTONIC``
   647		clock. To access the same clock outside V4L2, use
   648		:c:func:`clock_gettime`.
   649	    * .. _`V4L2-BUF-FLAG-TIMESTAMP-COPY`:
   650	
   651	      - ``V4L2_BUF_FLAG_TIMESTAMP_COPY``
   652	      - 0x00004000
   653	      - The CAPTURE buffer timestamp has been taken from the corresponding
   654		OUTPUT buffer. This flag applies only to mem2mem devices.
   655	    * .. _`V4L2-BUF-FLAG-TSTAMP-SRC-MASK`:
   656	
   657	      - ``V4L2_BUF_FLAG_TSTAMP_SRC_MASK``
   658	      - 0x00070000
   659	      - Mask for timestamp sources below. The timestamp source defines the
   660		point of time the timestamp is taken in relation to the frame.
   661		Logical 'and' operation between the ``flags`` field and
   662		``V4L2_BUF_FLAG_TSTAMP_SRC_MASK`` produces the value of the
   663		timestamp source. Applications must set the timestamp source when
   664		``type`` refers to an output stream and
   665		``V4L2_BUF_FLAG_TIMESTAMP_COPY`` is set.
   666	    * .. _`V4L2-BUF-FLAG-TSTAMP-SRC-EOF`:
   667	
   668	      - ``V4L2_BUF_FLAG_TSTAMP_SRC_EOF``
   669	      - 0x00000000
   670	      - End Of Frame. The buffer timestamp has been taken when the last
   671		pixel of the frame has been received or the last pixel of the
   672		frame has been transmitted. In practice, software generated
   673		timestamps will typically be read from the clock a small amount of
   674		time after the last pixel has been received or transmitten,
   675		depending on the system and other activity in it.
   676	    * .. _`V4L2-BUF-FLAG-TSTAMP-SRC-SOE`:
   677	
   678	      - ``V4L2_BUF_FLAG_TSTAMP_SRC_SOE``
   679	      - 0x00010000
   680	      - Start Of Exposure. The buffer timestamp has been taken when the
   681		exposure of the frame has begun. This is only valid for the
   682		``V4L2_BUF_TYPE_VIDEO_CAPTURE`` buffer type.
   683	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
