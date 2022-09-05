Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE5AD33C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiIEMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiIEMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:49:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02221FD4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:49:15 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220905124903euoutp0189b0e6f3930ab2f7517a07a5ae439b14~R98CCS5s-2548725487euoutp01c
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:49:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220905124903euoutp0189b0e6f3930ab2f7517a07a5ae439b14~R98CCS5s-2548725487euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662382143;
        bh=PF4oHLzqZh/YHdKNpdK5/2LeWbEyKKWZ2jrg1+aNG8s=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=E2ZwD1O0fOWh69ZAATRgk9L4xaHixrML9qlbRBYLAqA7BFQKa8K9UnArYN0pZKHdy
         EaIY45Awjpm4lUUve+q8NBnxe2NvTs4s/St6CN4O6LuQFUD8Bdg23Eq+GUT5knfKHH
         TFX3bvRL/ojRyPq3YZp2O7nQbMxEfJYwpZuJlGhg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220905124903eucas1p28ce03c18a615c26f6e946b15a149b325~R98BqlOKd0854408544eucas1p2x;
        Mon,  5 Sep 2022 12:49:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7E.D4.29727.F30F5136; Mon,  5
        Sep 2022 13:49:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220905124902eucas1p2ac0553ea1fe86340b5dbae2b66c22214~R98BE7RpE2754227542eucas1p2E;
        Mon,  5 Sep 2022 12:49:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220905124902eusmtrp2cc0a2e78a6eab472d306af045c0da798~R98BDlBjY0389703897eusmtrp2D;
        Mon,  5 Sep 2022 12:49:02 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-a7-6315f03f882d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.47.07473.E30F5136; Mon,  5
        Sep 2022 13:49:02 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220905124902eusmtip1f3535df1f02cd6b0b6a8939f6c046456~R98A2TTJK2174421744eusmtip1l;
        Mon,  5 Sep 2022 12:49:02 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 5 Sep 2022 13:49:01 +0100
Message-ID: <1ed819b5-924d-6a87-1978-1457061e2647@samsung.com>
Date:   Mon, 5 Sep 2022 14:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>, <bvanassche@acm.org>,
        <pankydev8@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <gost.dev@samsung.com>, <jaegeuk@kernel.org>,
        <matias.bjorling@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YxJttvB2Z5I58SQ5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87r2H0STDc7N47RYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
        vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddZfP4vEnOo/1AN1MAVxSXTUpqTmZZapG+XQJXRsPp3awFHzQrVr61a2BsUuxi5OCQEDCR
        aP5h0MXIxSEksIJRonvHYyYI5wujxKH5m9kgnM+MEs1fnjB2MXKCdcyf/IYZxBYSWM4ocXxW
        MlzRxKd32CGcXYwSM5r/soNU8QrYSdy80cUGYrMIqEj8eLaKCSIuKHFy5hMWEFtUIFJize6z
        YPXCAtkSS/uOg9nMAuISt57MZwK5VURAVeLWNBeI8CFmiQs3skHCbAJaEo2d7CAmJ5A5dVoJ
        RIWmROv231BD5CW2v53DDHG+ksSEeffZIOxaibXHzoBdLCFwj1OiZf0UqISLRPPdK0wQtrDE
        q+Nb2CFsGYn/O+dDxaslnt74zQzR3MIo0b9zPRskSK0l+s7kQNQ4SuxfcJ4ZIswnceOtIMQ9
        fBKTtk1nnsCoOgspHGYh+XcWkhdmIXlhASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxN
        jMAEePrf8U87GOe++qh3iJGJg/EQowQHs5IIb8oOkWQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vMmZGxKFBNITS1KzU1MLUotgskwcnFINTDnmlQdmq37f+tlHfFHuheOBC8xdrkdcCDp0iGHy
        wdcBkktXWcz+cfpoQmzyqXb1PW/F8xnv81nr5/5vfCDrz9lnuXf1V/kN3qFzNJ98+/zowOsX
        4aqblaJ2ugb/7y19NF9FYyr/MqcPM6wyXDd8yF0flHiz4vnvI06/Z+yK2vKjp0TT/Iic+eJn
        WzpLzt4KazgaJhW4QrFB7tDckOOql37c/TTFzsF4r+bRdVXfnli4O1i5KJXacry/HNVsreMY
        einn44NzJUsbArplgx9/MlgQzKHzMjjIjam60G7Hv2Nf0vYVZMmkv1HZ8MJyj8h9R0/flWfX
        lt3g+X/ZYNM/Gbs7vNEeeZWzFLd2p21e+0yJpTgj0VCLuag4EQAQLIGZ7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7p2H0STDXoPKVqsP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLVauPspk8WT9LGaLv133gGK3tC0u75rDZjF/2VN2iwlt
        X5kt1tx8ymJx4pa0RdvGr4wOAh6Xr3h77Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP
        9/uusnl83iTn0X6gmymAK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvo+H0btaCD5oVK9/aNTA2KXYxcnJICJhIzJ/8hrmLkYtDSGApo8TCz4uY
        IBIyEp+ufGSHsIUl/lzrYoMo+sgosXHbbRYIZxejxIkDT8A6eAXsJG7eAKni5GARUJH48WwV
        VFxQ4uTMJywgtqhApMTDZU1gcWGBbImlfcfBNjALiEvcejIfKM7BISKgKnFrmgvIfGaBQ8wS
        q3o3M0Esu8coce70YhaQIjYBLYnGTnYQkxPInDqtBGKMpkTr9t9QI+Ultr+dwwzxgJLEhHn3
        2SDsWolX93czTmAUnYXkullIrpiFZNQsJKMWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
        CEwe24793LyDcd6rj3qHGJk4GA8xSnAwK4nwpuwQSRbiTUmsrEotyo8vKs1JLT7EaAoMoonM
        UqLJ+cD0lVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwKQfuWav
        5fxPYpZ3ardkF3LIlzRwsrU2CxUcm2l3d16G5L9J+ucE4mbsFmVxdyv9y5hw6Mg7Ed/6+29Y
        nF5kKM4Rc9z988cTCalj3abzrx/pC+WZe3ced+KnAy9WGBax8L8OerM7Yanx7RWpIlZ28vpL
        E4wm/Vv8RUpUXORgCw9zRmD+jHqzf/8/mHJO4/v3ITxEK1q1c+6xA5uM5m9tmX5mtl3cyr9+
        7bZ3Kq47RgrazVoX0LbA/9+GLY3Rn4uFo8zd1pewFSXa/+owfqzM86uDK2VG7KOF+V1l0yRE
        Sus3L10s+Vbje/m8DbnL/r5sOl5XGMh/b3by5boz779WMP7c/mOrZWvMug2bnfcp+CmxFGck
        GmoxFxUnAgBNDRd8pwMAAA==
X-CMS-MailID: 20220905124902eucas1p2ac0553ea1fe86340b5dbae2b66c22214
X-Msg-Generator: CA
X-RootMTR: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
        <20220823121859.163903-14-p.raghav@samsung.com>
        <YxJttvB2Z5I58SQ5@redhat.com>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

>> Note that the target does not support partial mapping of the underlying
>> device.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
>> Suggested-by: Hannes Reinecke <hare@suse.de>
> 
> 
> This target needs more review from those who Suggested-by it.
> 
> And the header and docs needs to address:
> 
> 1) why is a partial mapping of the underlying device disallowed?
While it is technically possible, I don't see any use-case to do so for
this target. I can mention it in the documentation as well.

> 2) why is it assumed all IO is read-only? (talk to me and others like
>    we don't know the inherent limitations of this class of zoned hw)
>
TL;DR: no, we don't assume all IO to be read-only. All operations all
allowed until the zone capacity, and only reads are permitted in the
emulated gap area.

A bit of context about Zoned HW(especially ZNS SSD):

Zone: A contiguous range of logical block addresses managed as a single unit.
Zoned Block Device: A block device that consists of multiple zones.
Zone size: Size of a zone
Zone capacity: Usable logical blocks in a zone

According to ZNS spec, the LBAs from zone capacity to zone size behave like
deallocated blocks when read and are not allowed to be written. Until now,
zone capacity can be any value, but zone size needed to be a power-of-2 to
work in Linux (More information about this is also in my cover letter).

This patch series aims to allow non-po2 zone size devices with zone
capacity == zone size to work in Linux.

A non-po2 zone size device might not work correctly in filesystems that
support zoned devices such as btrfs and f2fs as they assume po2 zone sizes.
Therefore, this target is created to enable these filesystems to work with
non-po2 zone sizes until native support is added.

This target's zone capacity will be the same as the underlying device, but
the target's zone size will be the nearest po2 value of its zone capacity.
Furthermore, the area between the zone capacity and zone size of the target
(emulated gap area) will resemble the spec behavior: behave like the
deallocated blocks when read (we fill zeroes in the bio) and are not
allowed to write.

Does that clarify your question?
> On a code level:
> 1) are you certain you're properly failing all writes?
>    - are writes allowed to the "zone capacity area" but _not_
>      allowed to the "emulated zone area"? (if yes, _please document_). 
I have already documented in Documentation:

A simple remap is performed for all the BIOs that do not cross the
emulation gap area, i.e., the area between the zone capacity and size.

If a BIO lies in the emulation gap area, the following operations are
performed:

  Read:
    - If the BIO lies entirely in the emulation gap area, then zero out the
BIO and complete it.

    - If the BIO spans the emulation gap area, split the BIO across the
zone capacity boundary and remap only the BIO within the zone capacity
boundary. The other part of the split BIO will be zeroed out.

  Other operations:
    - Return an error

Maybe it is not clear enough?? Let me know.

> 2) yes, you absolutely need to implement the .status target_type hook
>    (for both STATUS and TABLE).
I already queued this change locally. I will send it as a part of the next rev.

> 3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
>    DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
>    prefer to not have to do a depth-first search to see where and when
>    dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
>    justification for it.  To me it just obfuscates the DM interface a
>    bit too much. 
> 
Got it. Do you prefer having the return statements in the dm_po2z_map
itself instead of returning a helper function, which in return returns the
status code?

What about something like this:

static inline void dm_po2z_read_zeroes(struct bio *bio)
{
	zero_fill_bio(bio);
	bio_endio(bio);
}

static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
{
	struct dm_po2z_target *dmh = ti->private;
	int split_io_pos;

	bio_set_dev(bio, dmh->dev->bdev);

	if (op_is_zone_mgmt(bio_op(bio)))
		goto remap_sector;

	if (!bio_sectors(bio))
		return DM_MAPIO_REMAPPED;

	if (!dm_po2z_bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
		goto remap_sector;

	/*
	 * Read operation on the emulated zone area (between zone capacity
	 * and zone size) will fill the bio with zeroes.Any other operation
	 * in the emulated area should return an error.
	 */
	if (bio_op(bio) == REQ_OP_READ) {
		/*
		 * If the bio is across emulated zone boundary, split
		 * the bio at
		 * the boundary.
		 */
		if (split_io_pos > 0) {
			dm_accept_partial_bio(bio, split_io_pos);
			goto remap_sector;
		}

		dm_po2z_read_zeroes(bio);
		return DM_MAPIO_SUBMITTED;
	}
	return DM_MAPIO_KILL;

remap_sector:
	bio->bi_iter.bi_sector =
		target_to_device_sect(dmh, bio->bi_iter.bi_sector);

	return DM_MAPIO_REMAPPED;
}

> Otherwise, pretty clean code and nothing weird going on.
> 
> I look forward to seeing your next (final?) revision of this patchset.
> 
> Thanks,
> Mike
> 
